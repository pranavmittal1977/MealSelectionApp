//
//  DetailView.swift
//  ClassProject
//
//  Created by Pranav Mittal on 10/15/23.
//




import SwiftUI

struct result: Identifiable, Codable {
    var id: Int64
    var title: String
    let image: String
    var type: String?
    let imageType: String
    
    let imageInfo: ImageInfo?

    struct ImageInfo: Codable {
        let image: String
    }
    
}

struct DetailView: View {
    @ObservedObject var foodM: FoodModel
    @Environment(\.dismiss) private var dismiss
    let food: String
    @Environment(\.presentationMode) var presentationMode
    @State var nameFood: String = ""
    //let api = "9134fe9310b3467db8df8d8d391e6087"
    //let api = "ee790e2ad322444c80e166b83dfcf0d6"
    let api = "7d0b6ecee82a4bffa16739bcbc7c9b88"
    @State private var searchResults: [result] = []
    var foodModel: FoodModel
    @State private var isFavorite: Bool = false
    
    
    //-------------
    
    //-------------
    
    
    var body: some View {
        VStack {
            Text(food)
                .font(.title)
                .bold()
                .padding()

            HStack {
                Spacer()
                Text("Food Name: ")
                TextField("Enter the food choice", text: $nameFood)
                Spacer()
            }
            .padding(20)

            Button("Search") {
                apiFunc()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)

            List(searchResults, id: \.id) { food in
                NavigationLink(destination: StepsIngredients(foodID: food.id, foodModel: FoodModel())) {
                    VStack(alignment: .leading) {
                        Text(food.title)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.bottom, 5)

                        if let imageUrl = food.imageInfo?.image {
                            Image(imageUrl)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                        }
                     

                        Text(food.type ?? "")
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                    }
                }
            }

  
        }
        .padding()
    }

    private func apiFunc() {
        let completeURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(api)&query=\(nameFood)"

        guard let url = URL(string: completeURL) else {
            print("Invalid URL")
            return
        }

        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) 
            
            else {
                print("Invalid response as you called it more than 150 times in a day")
                
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(FoodData.self, from: data)

                DispatchQueue.main.async {
                    self.searchResults = searchResults.results
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        urlSession.resume()
    }


}

 
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(foodM: FoodModel(), food: "", foodModel: FoodModel())
    }
}

