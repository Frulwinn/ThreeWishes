//
//  PersonRowController.swift
//  Gifting-watchOS Extension
//
//  Created by Lambda_School_Loaner_34 on 4/25/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import WatchKit

//kind of like a table view cell
class PersonRowController: NSObject {
    
    //MARK: - Properties
    var person: Person? {
        didSet {
            updateViews()
        }
    }

    //MARK: - Outlets
    @IBOutlet weak var birthdayLabel: WKInterfaceLabel!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var personGroup: WKInterfaceGroup!
    
    private func updateViews() {
        guard let person = person else { return }
        
        let birthdayLabelText = person.birthday
        let nameLabelText = person.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        birthdayLabel.setText(dateFormatter.string(for: birthdayLabelText))
        nameLabel.setText(nameLabelText)
        
        birthdayLabel.setTextColor(.cream)
        nameLabel.setTextColor(.brownRed)
        personGroup.setBackgroundColor(.deepRed)
    }
}
