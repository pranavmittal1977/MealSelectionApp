////
////  CoreDataController.swift
////  Homework1
////
////  Created by Pranav Mittal on 11/7/23.
//
//
//
//import Foundation
//import CoreData
//
//// CoreDataController.swift
//class CoreDataController: ObservableObject {
//    let persistentContainer: NSPersistentContainer
//
//    init() {
//        persistentContainer = NSPersistentContainer(name: "CoreData")
//        persistentContainer.loadPersistentStores { (description, error) in
//            if let error = error {
//                fatalError("Cannot load data \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func saveData(walking: String) {
//      
//        let newItem = Item(context: persistentContainer.viewContext)
//        
//        newItem.foodName = walking
//       
//        
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            fatalError("Unresolved error \(error), \(error.localizedDescription)")
//        }
//        
//        print("Data got inserted yayy")
//    }
//
//    func getAllData() -> [Item] {
//        do {
//            return try persistentContainer.viewContext.fetch(Item.fetchRequest())
//        } catch {
//            return []
//        }
//    }
//}
//
//
//
//
