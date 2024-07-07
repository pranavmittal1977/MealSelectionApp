//
//  Persistence.swift
//  coreDataImageSwiftUI
//
//  Created by Janaka Balasooriya on 3/5/23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    // Add a property for the managed object context
    let container: NSPersistentContainer

    // Add the managed object context as a computed property
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
