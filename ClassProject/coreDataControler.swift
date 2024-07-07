//
//  coreDataControler.swift
//  ClassProject
//
//  Created by Pranav Mittal on 11/18/23.
//




import Foundation
import CoreData

class coreDataController : ObservableObject {
    
    @Published var MoData: [Item] = [Item]()
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("cannot load data \(error.localizedDescription)")
            }
        }
        
        fetchAndSetMoData()
    }
    
    func saveMobile(lanNam: String, tit: String) {
        let mo = Item(context: persistentContainer.viewContext)
        mo.foodName = lanNam
        mo.id = Int64()
        mo.title = tit
        do {
            try persistentContainer.viewContext.save()
            fetchAndSetMoData()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func getFood() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)
            return x
        } catch {
            return []
        }
    }
    
    func deleteMo(mobile: Item) {
        persistentContainer.viewContext.delete(mobile)
        do {
            try persistentContainer.viewContext.save()
            fetchAndSetMoData()
        } catch {
            print("Failed to save after deletion: \(error)")
        }
    }
    
    // Internal function to fetch and set MoData
    func fetchAndSetMoData() {
        MoData = getFood()
    }
}
