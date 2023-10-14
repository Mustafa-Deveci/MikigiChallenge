//
//  GetTimelineModel.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation

// MARK: - GetTimelineModel
struct GetTimelineModel: Codable {
    let timeline: [Timeline]
    
    enum CodingKeys: String, CodingKey {
           case timeline = "timeline" // JSON anahtarı ile model anahtarını eşleştirin
       }
}

// MARK: - Timeline
struct Timeline: Codable {
    let id, imageURL: String?
    let mentions: [Mention]
    let date, title: String?
    let countryCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case mentions, date, title, countryCount
    }
}

// MARK: - Mention
struct Mention: Codable {
    let id, profileImage, fullname, userName: String?
    let isFollowing: Bool?
}
