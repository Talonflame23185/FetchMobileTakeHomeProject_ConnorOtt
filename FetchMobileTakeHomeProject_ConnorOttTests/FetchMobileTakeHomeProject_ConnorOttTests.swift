//
//  FetchMobileTakeHomeProject_ConnorOttTests.swift
//  FetchMobileTakeHomeProject_ConnorOttTests
//
//  Created by Connor Ott on 6/10/25.
//
import XCTest
import UIKit

@testable import FetchMobileTakeHomeProject_ConnorOtt

final class RecipeServiceTests: XCTestCase {
    // testing recipe fetching
    func testValidRecipesResponse() async throws {
        let service = RecipeService()
        let recipes = try await service.fetchRecipes()
        XCTAssertFalse(recipes.isEmpty, "Expected recipes to be fetched.")
    }
    // testing malformed recipes to ensure error is returned
    func testMalformedRecipesThrowsError() async {
        let malformedURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: malformedURL)
            _ = try JSONDecoder().decode(RecipeResponse.self, from: data)
            XCTFail("Expected decoding to fail.")
        } catch {
            XCTAssertTrue(true, "Correctly failed to decode malformed data.")
        }
    }
    // making sure empty recipe lists are properly handled
    func testEmptyRecipesHandled() async throws {
        let emptyURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        let (data, _) = try await URLSession.shared.data(from: emptyURL)
        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        XCTAssertEqual(decoded.recipes.count, 0, "Expected empty recipe list.")
    }
}

final class ImageCacheTests: XCTestCase {
    // testing image loading
    func testLoadImageFromRemoteAndCacheToDisk() async {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/sample-image.jpg"
        let cache = ImageCache.shared

        // Step 1: Remove the cached file if it exists
        let fileURL = cache.cacheDirectory.appendingPathComponent(urlString.hash.description)
        try? FileManager.default.removeItem(at: fileURL)

        // Step 2: Load the image (should fetch remotely)
        let image = await cache.loadImage(from: urlString)
        XCTAssertNotNil(image, "Expected image to be loaded from remote")

        // Step 3: Load the image again (should come from disk cache this time)
        let secondLoad = await cache.loadImage(from: urlString)
        XCTAssertNotNil(secondLoad, "Expected image to be loaded from cache")
    }
    // testing invalid URL properly returns nil
    func testLoadImageWithInvalidURLReturnsNil() async {
        let urlString = "invalid-url"
        let image = await ImageCache.shared.loadImage(from: urlString)
        XCTAssertNil(image, "Expected nil for invalid URL")
    }
}
