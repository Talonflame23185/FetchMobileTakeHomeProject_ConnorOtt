//
//  RecipeViewModel.swift
//  FetchMobileTakeHomeProject_ConnorOtt
//
//  Created by Connor Ott on 6/4/25.
//
import SwiftUI
import Foundation
// view model for loading the recipes
@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let service = RecipeService()

    func loadRecipes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            recipes = try await service.fetchRecipes()
            errorMessage = nil
        } catch RecipeError.emptyData {
            recipes = []
            errorMessage = "No recipes available."
        } catch {
            recipes = []
            errorMessage = "Failed to load recipes."
        }
    }
}
