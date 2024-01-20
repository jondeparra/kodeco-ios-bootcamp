//
//  UserStore.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/10/24.
//

import Foundation

class UserStore: ObservableObject {
    @Published var users = [User]()

    init() {
        do {
            try loadData()
        } catch {
            print("Failed to load data: \(error)")
        }
    }

    func loadData() throws {
        let fileManager = FileManager.default
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent("userinfo.json")

        if fileManager.fileExists(atPath: fileURL.path) {
            // Tries to load from the Documents directory first
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let userCollection = try decoder.decode(UserJSONData.self, from: data)
                self.users = userCollection.results
                return // Successfully loaded from Documents
            } catch {
                print("Error loading data from Documents: \(error)")
            }
        }

        // If the file is not in the Documents directory, tries loading from the Bundle
        if let bundleURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") {
            do {
                let data = try Data(contentsOf: bundleURL)
                let decoder = JSONDecoder()
                let userCollection = try decoder.decode(UserJSONData.self, from: data)
                self.users = userCollection.results
            } catch {
                throw error
            }
        } else {
            // Throws an error if the file is not found in either Documents or Bundle
            throw DataLoadingError.fileNotFound
        }
    }

    func saveData() {
        let fileManager = FileManager.default
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent("userinfo.json")

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(UserJSONData(results: [], info: Info(seed: "", results: 0, page: 0, version: "")))
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
