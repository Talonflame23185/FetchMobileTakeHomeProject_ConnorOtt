import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage?
    let urlString: String?

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Rectangle()
                .foregroundColor(.gray.opacity(0.3))
                .task {
                    if let urlString {
                        image = await ImageCache.shared.loadImage(from: urlString)
                    }
                }
        }
    }
}
