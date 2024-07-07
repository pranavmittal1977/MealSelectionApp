////
////  Favorites.swift
////  ClassProject
////
////  Created by Pranav Mittal on 10/15/23.
////
//
import SwiftUI
import CoreData
/*
struct Favorites: View {
    @ObservedObject var foodModel: FoodModel

    var body: some View {
        List {
            ForEach(foodModel.pre_food_data.filter { $0.isFavorited }) { food in
                HStack {
                    // Display food details
                    Text(food.food_name)

                    Spacer()

                    // Button to toggle favorite status
                    Button(action: {
                        if let index = foodModel.pre_food_data.firstIndex(where: { $0.id == food.id }) {
                            foodModel.pre_food_data[index].isFavorited.toggle()
                        }
                    }) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
    }
}
*/





//struct Favorites: View {
//    @ObservedObject var foodModel: FoodModel
//
//    var body: some View {
//        Text("Hello ")
//    }
//}

/*struct Favorites: View {
    @ObservedObject var foodModel: FoodModel

    var body: some View {
        List {
            ForEach(foodModel.favoriteDishIDs.sorted(), id: \.self) { foodID in
                if let food = foodModel.pre_food_data.first(where: { $0.id.uuidString == "\(foodID)" }) {
                    HStack {
                        // Display food details
                        Text(food.food_name)

                        Spacer()

                        // Button to toggle favorite status
                        Button(action: {
                            foodModel.removeFavorite(foodID: foodID)
                        }) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
        }
        .onAppear {
            // Ensure the view updates when the favoriteDishIDs change
            foodModel.loadFavorites()
        }
    }
}
*/

/*struct Favorites: View {
    @ObservedObject var foodModel: FoodModel

    var body: some View {
        List {
            ForEach(foodModel.favoriteDishIDs.sorted(), id: \.self) { foodID in
                if let food = foodModel.pre_food_data.first(where: { $0.id.uuidString == "\(foodID)" }) {
                    HStack {
                        // Display food details
                        Text(food.food_name)

                        Spacer()

                        // Button to toggle favorite status
                        Button(action: {
                            foodModel.removeFavorite(foodID: foodID)
                        }) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
        }
        .onAppear {
            // Ensure the view updates when the favoriteDishIDs change
            foodModel.loadFavorites()
        }
    }
}
*/

/*
    struct Favorites: View {
        @ObservedObject var foodModel: FoodModel
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        predicate: NSPredicate(format: "isFavorite == true"),
            animation: .default)
        private var items: FetchedResults<Item>
        


        
        var body: some View {
           List {
               Text("Favorites")     
                   .font(.title)
                   .bold()
                   .padding()
                ForEach(items) { item in
                    HStack {
                        // Display food details
                        Text(item.foodName ?? "" )
                        Text(item.title ?? "" )
                        
                        Spacer()

                        // Button to toggle favorite status
//                        Button(action: {
//                            print("remove called")
//                            foodModel.removeFavorite(foodID: item.id) // Assuming food.id is of type Int64
//                        }) {
//                            Image(systemName: "star.fill")
//                                .foregroundColor(.yellow)
//                        }
                    }
                }
            }
            .onAppear {
                // Ensure the view updates when the favoriteDishIDs change
                
                foodModel.loadFavorites()
                foodModel.saveFavorites()
            }
            
            
        }
        
    }

*/
struct Favorites: View {
   // @ObservedObject var foodModel: FoodModel
    @Environment(\.managedObjectContext) private var viewContext

    var name:String
    
    var body: some View {

        Text(name)
    }
}

    struct Favorites_Previews: PreviewProvider {
        static var previews: some View {
            //Favorites(foodModel: FoodModel())
            Favorites(name: "")
        }
    }
