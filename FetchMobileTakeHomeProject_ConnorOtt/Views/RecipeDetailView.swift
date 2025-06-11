import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(urlString: recipe.photo_url_large)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                    .foregroundColor(.secondary)

                if let sourceURL = recipe.source_url, let url = URL(string: sourceURL) {
                    Link("View Full Recipe", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                if let youtubeURL = recipe.youtube_url, let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .font(.headline)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
