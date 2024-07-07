    //
    //  FoodModel.swift
    //  ClassProject
    //
    //  Created by Pranav Mittal on 10/15/23.
    //


import Combine
import SwiftUI
import CoreData



    struct FoodData: Decodable {
        var results: [result]
    }

    struct Food: Identifiable, Codable, Hashable {
        var id = UUID()
        var food_name: String
        var food_image: String
        var isFavorited: Bool //   isFavorited property

        init(food_name: String, food_image: String, isFavorited: Bool = false) {
            self.food_name = food_name
            self.food_image = food_image
            self.isFavorited = isFavorited
        }
    }


    public class FoodModel: ObservableObject {
        
       private let persistenceController = PersistenceController.shared
        @Published var favoriteDishIDs: Set<Int64> = []
        private let viewContext = PersistenceController.shared.viewContext
        
        private let dataModel = DataModel()
        
        
        @Published var pre_food_data = [Food(food_name: "Asian", food_image: "asian"),
                                          Food(food_name: "Breakfast", food_image: "breakfast"  ),
                                          Food(food_name: "Italian", food_image: "download" ),
                                          Food(food_name: "German", food_image: "german" ),
                                          Food(food_name: "Light & Lovely", food_image: "light"  ),
                                          Food(food_name: "Quick & Easy", food_image: "quickEasy")]
        
        
        
        var food_counter: Int{
            
            pre_food_data.count
        }
        
        func getFoodDetail(at i: Int) -> Food{
            
            return pre_food_data[i]
        }
        
        func add_Food(food: Food) {
            pre_food_data.append(food)
        }
        
        func delete_Food(at i: Int) {
            pre_food_data.remove(at: i)
        }
        
        func foodSearch(food: String) -> Int {
            
            var location: Int = 0
            print(food)
            for c in pre_food_data
            {
                if c.food_name == food
                {
                    break;
                  
                }
                location = location + 1
                print(location)
            }
            return location
        }
        
        //----------------------------------
        
        func searchRecipes(foodName: String, completion: @escaping ([result]) -> Void) {
            //let apiKey = "ee790e2ad322444c80e166b83dfcf0d6"
            //let apiKey = "ee790e2ad322444c80e166b83dfcf0d6"
            let apiKey = "7d0b6ecee82a4bffa16739bcbc7c9b88"
            let fullURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(foodName)"

            guard let url = URL(string: fullURL) else {
                return
            }

            let urlSession = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let searchResults = try decoder.decode(FoodData.self, from: data)
                        DispatchQueue.main.async {
                            completion(searchResults.results)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }
            urlSession.resume()
        }


        func fetchRecipe(foodID: Int64, completion: @escaping (Recipe?) -> Void) {
            //let apiKey = "9134fe9310b3467db8df8d8d391e6087"
            let apiKey = "7d0b6ecee82a4bffa16739bcbc7c9b88"
            let fullURL = "https://api.spoonacular.com/recipes/\(foodID)/information?apiKey=\(apiKey)"

            guard let url = URL(string: fullURL) else {
                return
            }

            let urlSession = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let recipe = try decoder.decode(Recipe.self, from: data)
                        DispatchQueue.main.async {
                            completion(recipe)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }
            urlSession.resume()
        }
        
        
        //------------------------------------
        
        func isFavorite(food: Food) -> Bool {
            return pre_food_data.contains(where: { $0.id == food.id && $0.isFavorited })
        }

        func toggleFavorite(food: Food) {
            if let index = pre_food_data.firstIndex(where: { $0.id == food.id }) {
                pre_food_data[index].isFavorited.toggle()
            }
        }


        //-------------------------------------------------
        
        func isFavorite(foodID: Int64) -> Bool {
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %lld", foodID)

            do {
                let matchingItems = try viewContext.fetch(fetchRequest)
                return !matchingItems.isEmpty
            } catch {
                print("Error fetching items: \(error)")
                return false
            }
        }



        func addFavorite(foodID: Int64, foodName: String) {
            
            print("addFavorite")
            dataModel.addFavoriteItem(foodID: foodID, foodName: "")
        }

        func removeFavorite(foodID: Int64, foodName: String) {
            dataModel.removeFavoriteItem(foodID: foodID, foodName: "")
            print("removeFavorite")
        }

      

        // Function to save favorites to UserDefaults
        public func saveFavorites() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(Array(favoriteDishIDs)) {
                UserDefaults.standard.set(encoded, forKey: "favoriteDishIDs")
                print("Saved !!!")
            }
        }

        // Function to load favorites from UserDefaults
        public func loadFavorites() {
            if let data = UserDefaults.standard.data(forKey: "favoriteDishIDs") {
                let decoder = JSONDecoder()
                if let favorites = try? decoder.decode([Int64].self, from: data) {
                    favoriteDishIDs = Set(favorites)
                    print("Loaded Favorite Dish IDs: \(favoriteDishIDs)")
                }
            }
        }
        
        

        
}
