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
        //takes place of numberOfRowsInSection
        //return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        //hey table this is your number of rows
        //pushing information
        personTable.setNumberOfRows(fetchedResultsController.section(forSectionIndexTitle: Person.self, at: 1), withRowType: "PersonRow")
        
        //loops through the people and pass one to one row that it corresponds to
        //enumerated sequence returns pair (n, x) where index represents a consecutive integer starting at zero and person represents an element of the sequence in the array
        //makes index for you
        for (index, person) in Person.enumerated() {
            //hey rowController
            let rowController = personTable.rowController(at: index) as! PersonRowController
            //this is what you need to display
            rowController.person = person
        }
        
    }
    
    //this allows when clicking on the row takes you to the detail view controller
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        //return the thing that you want to pass to the new interface controller
        return person[rowIndex]
    }
}
