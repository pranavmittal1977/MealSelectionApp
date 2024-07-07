//
//  Item.swift
//  ClassProject
//
//  Created by Pranav Mittal on 11/18/23.
//

import Foundation
// Item+Extensions.swift


import CoreData

extension Item {
    // Add a convenience method to create a fetch request with a predicate for isFavorite
    @NSManaged public var isFavorite: Bool
    static func fetchRequest(with id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        request.predicate = NSPredicate(format: "id == %lld", id)
        return request
    }

    // Add a property to store favorite status
    
}
