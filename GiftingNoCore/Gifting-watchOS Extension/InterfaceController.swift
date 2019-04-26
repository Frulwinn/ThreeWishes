//
//  InterfaceController.swift
//  Gifting-watchOS Extension
//
//  Created by Lambda_School_Loaner_34 on 4/24/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class InterfaceController: WKInterfaceController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Properties
    let personController = PersonController()
    var people: [Person]{
        let fetchedRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        let people = (try? moc.fetch(fetchedRequest)) ?? []
        
        return people
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        let fetchedRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        fetchedRequest.sortDescriptors = [
            NSSortDescriptor(key: "birthday", ascending: true),
        ]
        
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: moc, sectionNameKeyPath: "birthday", cacheName: nil)
        
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var personTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _ = fetchedResultsController
        
        PersonController().fetchPersonFromServer { (_) in
            self.personTable.setNumberOfRows(self.people.count , withRowType: "PersonRow")
            
            //guard let people = fetchedResultsController.fetchedObjects?.enumerated() else { return }
            for (index, person) in self.people.enumerated() {
                
                let rowController = self.personTable.rowController(at: index) as! PersonRowController
                rowController.person = person
            }
        }
    }
    
    //this allows when clicking on the row takes you to the detail view controller
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        //return the thing that you want to pass to the new interface controller
        return people[rowIndex]
    }
}
