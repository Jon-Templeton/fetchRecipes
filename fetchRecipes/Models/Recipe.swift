//
//  Receipe.swift
//  fetchRecipes
//
//  Created by Jon Templeton on 10/31/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}


struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
