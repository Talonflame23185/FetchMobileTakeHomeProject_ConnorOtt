import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0]
    }

    func loadImage(from urlString: String) async -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(urlString.hash.description)

        if fileManager.fileExists(atPath: fileURL.path),
           let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            return image
        }

        guard let url = URL(string: urlString),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            return nil
        }

        try? data.write(to: fileURL)
        return image
    }
}
