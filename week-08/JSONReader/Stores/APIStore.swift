//
//  APIStore.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/9/24.
//

import Foundation

class APIStore: ObservableObject {
    @Published var apis = [API]()

    init() {
        Task {
            do {
                try await loadData()
            } catch {
                print("Failed to load data: \(error)")
            }
        }
    }

    func loadData() async throws {
        do {
            try await fetchData() // First try to fetch data from the network
        } catch {
            print("Network fetch failed, trying local data: \(error)")
            try loadLocalData() // If network fetch fails, try loading local data
        }
    }

    func fetchData() async throws {
        guard let url = URL(string: "https://api.publicapis.org/entries") else {
            throw DataLoadingError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // 1 minute
        configuration.timeoutIntervalForResource = 60 * 60 // 1 hour
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataLoadingError.networkError
        }

        let decoder = JSONDecoder()
        let apiCollection = try decoder.decode(APIJSONData.self, from: data)
        await MainActor.run { self.apis = apiCollection.entries }
        saveData()
    }

    private func loadLocalData() throws {
        let fileManager = FileManager.default
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent("apilist.json")

        if fileManager.fileExists(atPath: fileURL.path) {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let apiCollection = try decoder.decode(APIJSONData.self, from: data)
            self.apis = apiCollection.entries
        } else if let bundleURL = Bundle.main.url(forResource: "apilist", withExtension: "json") {
            let data = try Data(contentsOf: bundleURL)
            let decoder = JSONDecoder()
            let apiCollection = try decoder.decode(APIJSONData.self, from: data)
            self.apis = apiCollection.entries
        } else {
            throw DataLoadingError.fileNotFound
        }
    }

    func saveData() {
        let fileManager = FileManager.default
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent("apilist.json")

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(APIJSONData(count: self.apis.count, entries: self.apis))
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
