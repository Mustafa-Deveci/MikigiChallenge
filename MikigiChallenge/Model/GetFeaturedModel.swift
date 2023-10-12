//
//  GetFeaturedModel.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation

// MARK: - Welcome
struct GetFeaturedModel: Codable {
    let featured: [Featured]
}

// MARK: - Featured
struct Featured: Codable {
    let id, city, country, imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, city, country
        case imageURL = "imageUrl"
    }
}
