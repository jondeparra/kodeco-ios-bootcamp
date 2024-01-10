//
//  APICollection.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/9/24.
//

import Foundation

struct APICollection: Codable {
    var count: Int
    var entries: [API]
}
