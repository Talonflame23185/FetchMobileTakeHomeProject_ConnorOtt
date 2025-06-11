//
//  RecipeModel.swift
//  FetchMobileTakeHomeProject_ConnorOtt
//
//  Created by Connor Ott on 6/4/25.
//
import Foundation
// model for the recipes
struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    var id: UUID { UUID(uuidString: uuid) ?? UUID() }

    let uuid: String
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?
}

