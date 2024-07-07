//
//  ContentView.swift
//  ClassProject
//
//  Created by Pranav Mittal on 10/13/23.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var foodModel = FoodModel()
    @State var plus_Sign = false
    @State var foodN: String
    //@Environment(\.dismiss) private var dismiss
    @State var showFavorites = false
    
 
    
    var body: some View {
        TabView(){
        NavigationView{
           
            
            List{
                ForEach(foodModel.pre_food_data, id: \.id){food in NavigationLink(destination: DetailView(foodM:foodModel, food: food.food_name, foodModel: FoodModel())){
                
                    HStack{
                        
                        
                        
                        
                        Image(food.food_image).resizable().scaledToFit().frame(height: 80).cornerRadius(10)
                        VStack(alignment: .leading, spacing: 10){
                            
                            Text(food.food_name).fontWeight(.semibold)
                                .minimumScaleFactor(0.5)
                        }
                        //new
                    
                        
                        //---------------------
                    }
                    
                }
                    
                }.onDelete(perform: {IndexSet in foodModel.pre_food_data.remove(atOffsets: IndexSet)})
            }.navigationBarTitleDisplayMode(.inline).navigationTitle("Meal Selection App").navigationBarTitleDisplayMode(.inline).toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        plus_Sign = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }.alert("Food Category Name", isPresented: $plus_Sign,
                    actions: {
                TextField("Enter Food Name:", text: $foodN)
                
                Button("Insert", action: {

                    let c:Food = Food(food_name: foodN, food_image: "food")
                    foodModel.add_Food(food: c)
                    

                })
                Button("Cancel", role: .cancel, action: {
                    plus_Sign = false
                })
            }, message: {
                Text("Please Enter the Food Category you want to add")}).tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)).tabItem {
                    Label("Map", systemImage: "map")
                }
           
            
        }.tabItem {
            Label("Menu", systemImage: "menucard.fill")
        }

        MapView(foodM: foodModel, food: "")
            .tabItem {
                Label("Map", systemImage: "map")
            }

 
     

            
            StepsIngredients(foodID: 1, foodModel: foodModel)
                .tabItem {
                    Label("Steps & Favorites", systemImage: "list.bullet.clipboard") // Use an appropriate system image
                }


    }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(foodN: "")
    }
}
