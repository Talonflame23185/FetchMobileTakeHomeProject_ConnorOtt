//
//  RecipeService.swift
//  FetchMobileTakeHomeProject_ConnorOtt
//
//  Created by Connor Ott on 6/4/25.
//
import Foundation
// service for getting the recipes from the JSON endpoint
enum RecipeError: Error {
    case badURL, decodingError, emptyData, malformedData
}

class RecipeService {
    private let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: url)

        guard let decoded = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
            throw RecipeError.malformedData
        }

        if decoded.recipes.isEmpty {
            throw RecipeError.emptyData
        }

        return decoded.recipes
    }
}

