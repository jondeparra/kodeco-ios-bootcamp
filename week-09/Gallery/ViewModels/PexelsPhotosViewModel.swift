//
//  PexelsPhotosViewModel.swift
//  Gallery
//
//  Created by Jonathan Parra on 2/4/24.
//

import Foundation

class PexelsPhotosViewModel: ObservableObject {
    @Published var photos: [PexelsPhoto] = []
    @Published var page = 1
    private var perPage = 20
    private var isFetching = false

    func searchPhotos(query: String) {
        guard !isFetching else { return }
        guard !query.isEmpty else { return }
        isFetching = true

        guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)&per_page=\(perPage)") else { return }

        if let apiKey = loadAPIKey() {
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                Task { @MainActor in
                    if let error = error {
                        print("Network request error: \(error)")
                    }

                    guard let data = data else { return }

                    do {
                        let decodedResponse = try JSONDecoder().decode(PexelsResponse.self, from: data)
                        self.photos.append(contentsOf: decodedResponse.photos)
                        self.page += 1
                        self.isFetching = false
                    } catch {
                        print("JSON Decoding error: \(error)")
                    }
                }
            }.resume()
        }
    }

    func loadAPIKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["PexelsAPIKey"] as? String else {
            return nil
        }
        return apiKey
    }

    func clearPhotos() {
        self.photos = []
    }
}
