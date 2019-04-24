//
//  WishListTableViewController.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit
import CoreData


class WishListTVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Properties
    let personController = PersonController()
    var dateChanger = ISO8601DateFormatter()
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBAction func addPerson(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setTheme()
        
    }
    
    func setTheme() {
        view.backgroundColor = .deepRed
        tableView.separatorColor = .brownRed
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? TableViewCell else {fatalError("unable to dequeue tableview cell") }

        let person = fetchedResultsController.object(at: indexPath)
        cell.person = person
        style(cell: cell)
        return cell
    }
    
    func style(cell: UITableViewCell) {
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let view = view as! UITableViewHeaderFooterView
        let colorView = UIView(frame: view.frame)
        colorView.backgroundColor = .pale //UIColor.white.withAlphaComponent(0.5)
        view.backgroundView = colorView
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchedResultsController.object(at: indexPath)
            personController.delete(person: person)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return nil }
        guard let cleanString = formatBadDate(sectionInfo.name),
        let date = dateChanger.date(from: cleanString) else { return nil }
        
          let formattedString = dateFormatter.string(from: date)
        
        return formattedString
    }
    
    func formatBadDate(_ dateString: String) -> String? {
        var formattedString = dateString
        
        guard let firstSpace = dateString.firstIndex(of: " ") else { return nil }
        formattedString.remove(at: firstSpace)
        formattedString.insert("T", at: firstSpace)
        
        return formattedString.replacingOccurrences(of: " ", with: "")
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    //tell the table view that we're going to update it
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    //tell the table view that we're done updating it
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //how do we want to update the tableview in response to a change on a task
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
            
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    let sharedUserDefaults = UserDefaults(suiteName: "group.com.Frulwinn.Gifting")!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personSegue" {
            
            if let destinationVC = segue.destination as? WishDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                let person = fetchedResultsController.object(at: indexPath)
                
                destinationVC.person = person
                destinationVC.personController = personController
            }
        } else if segue.identifier == "addSegue" {
            let destinationVC = segue.destination as? WishDetailViewController
            destinationVC?.personController = personController
        }
    }
}
