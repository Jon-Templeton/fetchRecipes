//
//  RecipeMainView.swift
//  fetchRecipes
//
//  Created by Jon Templeton on 10/31/24.
//

import SwiftUI
import asnycImage

struct RecipeMainView: View {
    @State var recipes: [Recipe] = []
    @State var apiError: Bool = false
    @State private var selectedCuisine: String? = nil
    
    private var availableCuisines: [String] {
        let cuisines = Set(recipes.map { $0.cuisine })
        return ["All"] + Array(cuisines).sorted()
    }
    
    private var filteredRecipes: [Recipe] {
        guard let selectedCuisine = selectedCuisine, selectedCuisine != "All" else {
            return recipes
        }
        return recipes.filter { $0.cuisine == selectedCuisine }
    }
    
    private func fetchRecipes() async {
        do {
            self.recipes = try await RecipeAPI.shared.fetchRecipes()
            self.apiError = false
        } catch {
            self.apiError = true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(availableCuisines, id: \.self) { cuisine in
                            CuisineFilterButton(selectedCuisine: $selectedCuisine, cuisine: cuisine)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                List {
                    if apiError || recipes.isEmpty {
                        Text(apiError ? "Error connecting to server..." : "No recipes available...")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, minHeight: 250)
                            .listRowBackground(Color.clear)
                    } else {
                        ForEach(filteredRecipes) { recipe in
                            RecipeListView(recipe: recipe)
                        }
                    }
                }
            }
            .refreshable {
                await fetchRecipes()
            }
            .onAppear {
                Task {
                    await fetchRecipes()
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RecipeListView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if (recipe.photoUrlSmall != nil) {
                CAsyncImage(urlString: recipe.photoUrlSmall!) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                    
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .padding(.leading)
        }
    }
}

struct CuisineFilterButton: View {
    @Binding var selectedCuisine: String?
    let cuisine: String
    
    var body: some View {
        Button(action: {
            selectedCuisine = cuisine == "All" ? nil : cuisine
        }) {
            Text(cuisine)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(selectedCuisine == cuisine || (cuisine == "All" && selectedCuisine == nil)
                            ? Color.blue
                            : Color.gray.opacity(0.2))
                )
                .foregroundColor(
                    selectedCuisine == cuisine || (cuisine == "All" && selectedCuisine == nil)
                        ? .white
                        : .primary
                )
        }
    }
}



#Preview {
    struct PreviewWrapper: View {
        let recipes = [Recipe(id: "123", cuisine: "British", name: "Apple & Blackberry Crumble", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg", sourceUrl: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble", youtubeUrl: "https://www.youtube.com/watch?v=4vhcOwVBDO4")]
        var body: some View {
            RecipeMainView(recipes: recipes)
        }
    }
        return PreviewWrapper()
}
