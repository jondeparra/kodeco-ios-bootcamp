//
//  PexelsResponse.swift
//  Gallery
//
//  Created by Jonathan Parra on 2/4/24.
//

import Foundation

struct PexelsResponse: Codable {
    let totalResults: Int?
    let page: Int?
    let perPage: Int?
    let photos: [PexelsPhoto]
    let nextPage: String?
    let prevPage: String?

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
        case nextPage = "next_page"
        case prevPage = "prev_page"
    }
}
