//
//  ClassProjectApp.swift
//  ClassProject
//
//  Created by Pranav Mittal on 10/13/23.
//
//
import SwiftUI

@main
struct ClassProjectApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        
        WindowGroup {
            ContentView(foodN: "").environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}


