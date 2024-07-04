//
//  PlayerImageURLs.swift
//  sports-odds-client
//
//  Created by Mickens on 7/3/24.
//

import Foundation

struct PlayerImageUrls: Decodable, Hashable {
    let originalURL: URL?
    let thumbnailURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case originalURL = "original_url"
        case thumbnailURL = "thumbnail_url"
    }
    
    static var random: PlayerImageUrls {
        PlayerImageUrls(
            originalURL: URL(string: "https://example.com/original.png")!,
            thumbnailURL: URL(string: "https://example.com/thumbnail.png")!
        )
    }
}
