//
//  PexelsPhoto.swift
//  Gallery
//
//  Created by Jonathan Parra on 2/4/24.
//

import Foundation

struct PexelsPhoto: Codable, Identifiable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
    let src: PhotoSource
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer, liked, alt, src
        case photographerUrl = "photographer_url"
        case photographerId = "photographer_id"
        case avgColor = "avg_color"
    }
}

extension PexelsPhoto {
    static let example = PexelsPhoto(
        id: 3573351,
            width: 3066,
            height: 3968,
            url: "https://www.pexels.com/photo/trees-during-day-3573351/",
            photographer: "Lukas Rodriguez",
            photographerUrl: "https://www.pexels.com/@lukas-rodriguez-1845331",
            photographerId: 1845331,
            avgColor: "#374824",
            src: PhotoSource(
                original: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png",
                large2x: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                large: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=650&w=940",
                medium: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=350",
                small: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130",
                portrait: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                landscape: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                tiny: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
            ),
            liked: false,
            alt: "Brown Rocks During Golden Hour"
    )
}

struct PhotoSource: Codable {
    let original: String
    let large2x: String?
    let large: String?
    let medium: String?
    let small: String?
    let portrait: String?
    let landscape: String?
    let tiny: String?
}
