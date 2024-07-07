//
//  StepsIngredients.swift
//  ClassProject
//
//  Created by Pranav Mittal on 10/15/23.
//



import SwiftUI
import CoreData
struct StepsIngredients: View {
    var foodID: Int64
    @State private var recipe: Recipe?
    var foodModel: FoodModel
    @State private var isFavorite: Bool = false
    @State private var showFavorites: Bool = false
    @State private var favoriteNames: [String] = [] // Array to store favorite names

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let recipe = recipe {
                        Text(recipe.title)
                            .font(.title)
                            .bold()
                            .padding(.bottom, 8)

                        Text("Summary:")
                            .font(.headline)
                            .bold()
                        Text(recipe.summary)
                            .foregroundColor(.black)
                            .padding(.bottom, 5)

                        Button(action: {
                            toggleFavorite(recipe.title)
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(isFavorite ? .red : .gray)
                                .padding()
                        }

                        Text("Favorites")
                            .font(.title)
                            .bold()
                            .padding(.bottom, 8)

                        NavigationLink(destination: FavoritesView(favoriteNames: favoriteNames, onDelete: deleteFavorite), isActive: $showFavorites) {
                            Text("Show Favorites")
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text("Loading...")
                            .padding()
                    }
                }
                .padding()
            }
            .onAppear {
                self.isFavorite = foodModel.isFavorite(foodID: foodID)
                // Load favorite names from UserDefaults
                if let storedNames = UserDefaults.standard.stringArray(forKey: "favoriteNames") {
                    self.favoriteNames = storedNames
                }

                foodModel.fetchRecipe(foodID: foodID) { recipe in
                    self.recipe = recipe
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func toggleFavorite(_ name: String) {
        isFavorite.toggle()

        if isFavorite {
            // Add to favorites
            if !favoriteNames.contains(name) {
                favoriteNames.append(name)
            }
        } else {
//            // Remove from favorites
//            if let index = favoriteNames.firstIndex(of: name) {
//                favoriteNames.remove(at: index)
//            }
        }

        // Save favorite names to UserDefaults
        UserDefaults.standard.set(favoriteNames, forKey: "favoriteNames")
    }

    private func deleteFavorite(at indexSet: IndexSet) {
        favoriteNames.remove(atOffsets: indexSet)
        // Save updated favorite names to UserDefaults
        UserDefaults.standard.set(favoriteNames, forKey: "favoriteNames")
    }
}

struct StepsIngredients_Previews: PreviewProvider {
    static var previews: some View {
        StepsIngredients(foodID: 1, foodModel: FoodModel())
    }
}

struct FavoritesView: View {
    var favoriteNames: [String]
    var onDelete: (IndexSet) -> Void

    var body: some View {
        VStack {
            Text("Favorites View")
                .font(.title)
                .bold()
                .padding()

            List {
                ForEach(favoriteNames, id: \.self) { name in
                    Text(name)
                }
                .onDelete(perform: onDelete)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
