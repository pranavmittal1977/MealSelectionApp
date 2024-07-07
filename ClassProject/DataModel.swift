//
//  DataModel.swift
//  ClassProject
//
//  Created by Pranav Mittal on 11/18/23.
//

import Foundation
import SwiftUI
import CoreData
class DataModel {
    
    let viewContext = PersistenceController.shared.container.viewContext
   
    private var items: FetchedResults<Item>?
    

    func addFavoriteItem(foodID: Int64, foodName: String) {
            withAnimation {
                do {
                    // Fetch the item from Core Data using its ID
                    if let existingItem = try? viewContext.fetch(Item.fetchRequest(with: foodID)).first as? Item {
                        existingItem.isFavorite = true
                        existingItem.title = foodName
                        existingItem.id = foodID
                        try viewContext.save()
                        print("add Done")
                    }
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    print("add Failed")
                }
            }
        }

        func removeFavoriteItem(foodID: Int64, foodName: String) {
            withAnimation {
                do {
                    // Fetch the item from Core Data using its ID
                    if let existingItem = try? viewContext.fetch(Item.fetchRequest(with: foodID)).first as? Item {
                        existingItem.isFavorite = false
                        existingItem.title = foodName
                        existingItem.id = foodID
                        try viewContext.save()
                        print("remove Done")
                    }
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    print("remove failed")
                }
            }
        }
       
    func loadFavorites() {
        // Load favorite items from Core Data
        // Update your FetchedResults to include a predicate for filtering favorites
        items = try? viewContext.fetch(Item.fetchRequest()) as! FetchedResults<Item>
    }
}

