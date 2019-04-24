//
//  CoreDataStack.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import CoreData

public class CoreDataStack {
    
    public static let shared = CoreDataStack()
    
    public lazy var container: NSPersistentContainer = {
        
        // Give the container the name of your data model file
        let container = NSPersistentContainer(name: "Gifting")
        
        // Load the persistent store
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        //whenever there is a change to background context it will merget to main context
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // This should help you remember that the viewContext should be used on the main thread
    public var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
