//
//  DetailInterfaceController.swift
//  Gifting-watchOS Extension
//
//  Created by Lambda_School_Loaner_34 on 4/25/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {
    
    //MARK: - Properties
    private let fetcher = PersonController()
    
    private var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    let sharedUserDefaults = UserDefaults(suiteName: "group.com.Frulwinn.Gifting")!
    
    //MARK: - Outlets
    @IBOutlet weak var firstChoiceLabel: WKInterfaceLabel!
    @IBOutlet weak var secondChoiceLabel: WKInterfaceLabel!
    @IBOutlet weak var thirdChoiceLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //grab person from context
        let person = context as! String
        //set title
        setTitle(person)
        
        //fetch the firstChoice, secondChoice, thirdChoice for that person
        fetcher.fetchOnePersonFromServer(identifier: person, context: CoreDataStack.shared.mainContext) {
            
            //we set the firstChoice, secondChoice, and thirdChoice for that person
            //since updateviews is running in background thread we want to set these on the main queue so that when it gets to updateviews it sets it on the main queue
            DispatchQueue.main.async {
                self.firstChoice = firstChoice
                self.secondChoice = secondChoice
                self.thirdChoice = thirdChoice
            }
        }
    }
    
    private func updateViews() {
        guard let person = person else { return }
        
        let firstChoiceLabelText = person.firstChoice
        let secondChoiceLabelText = person.secondChoice
        let thirdChoiceLabelText = person.thirdChoice
        
        firstChoiceLabel.setText(firstChoiceLabelText)
        secondChoiceLabel.setText(secondChoiceLabelText)
        thirdChoiceLabel.setText(thirdChoiceLabelText)
    }
}
