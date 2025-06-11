//
//  RecipeView.swift
//  FetchMobileTakeHomeProject_ConnorOtt
//
//  Created by Connor Ott on 6/10/25.
//
import SwiftUI
// RecipeView is the main page that opens when the app is loaded
// UI view for list of recipes from JSON endpoint
struct RecipeView: View {
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRowView(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                Button("Refresh") {
                    Task {
                        await viewModel.loadRecipes()
                    }
                }
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
    }
}

#Preview {
    RecipeView()
}
