//
//  Gifting+Convenience.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import CoreData

extension Person {
    convenience init(name: String, birthday: Date, firstChoice: String?, secondChoice: String?, thirdChoice: String?, identifier: String = UUID().uuidString, isBought: Bool = false, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.name = name
        self.birthday = birthday
        self.firstChoice = firstChoice
        self.secondChoice = secondChoice
        self.thirdChoice = thirdChoice
        self.identifier = identifier
        self.isBought = isBought
    }
    
    convenience init?(personRepresentation: PersonRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let identifier = UUID(uuidString: personRepresentation.identifier),
            let isBought = personRepresentation.isBought else { return nil }
        
        self.init(name: personRepresentation.name, birthday: personRepresentation.birthday, firstChoice: personRepresentation.firstChoice, secondChoice: personRepresentation.secondChoice, thirdChoice: personRepresentation.thirdChoice, identifier: personRepresentation.identifier, isBought: isBought, context: context)
    }
    
}
