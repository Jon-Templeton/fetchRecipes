//
//  RecipeAPI.swift
//  fetchRecipes
//
//  Created by Jon Templeton on 10/31/24.
//

import Foundation

class RecipeAPI {
    static let shared = RecipeAPI()
    private let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedDataUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyDataUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    private var chosenURL: String {
        // duplicate value to increase random odds of baseURL
        [baseURL, baseURL, baseURL, baseURL, malformedDataUrl, emptyDataUrl].randomElement()!
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: chosenURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return recipeResponse.recipes
    }
}
