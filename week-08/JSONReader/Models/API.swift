//
//  API.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/9/24.
//

import Foundation

struct APIJSONData: Codable {
    var count: Int
    var entries: [API]

    enum CodingKeys: String, CodingKey {
        case count, entries
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(entries, forKey: .entries)
    }
}

struct API: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var auth: String
    var https: Bool
    var cors: String
    var link: String
    var category: String

    static let example = API(name: "MyAnimeList", description: "Anime and Manga Database and Community", auth: "OAuth", https: true, cors: "Unknown", link: "https://myanimelist.net/clubs.php?cid=13727", category: "Anime")

    enum CodingKeys: String, CodingKey {
        case name = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
