//
//  PersistenceContainer.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 4/24/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation
import CoreData

class PersistentContainer: NSPersistentContainer{
    override class func defaultDirectoryURL() -> URL{
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.Frulwinn.Gifting")!
    }
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
}
