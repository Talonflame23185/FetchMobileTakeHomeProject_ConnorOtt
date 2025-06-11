import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImageView(urlString: recipe.photo_url_small)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading) {
                Text(recipe.name).font(.headline)
                Text(recipe.cuisine).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}
