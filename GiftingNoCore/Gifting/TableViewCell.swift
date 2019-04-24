//
//  TableViewCell.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - Properties
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wishLabel: UILabel!
    
    func updateViews() {
        guard let person = person else { return }
        
        nameLabel.text = person.name
        wishLabel.text = person.firstChoice
        
        nameLabel.font = Appearance.gillSansFont(with: .caption1, pointSize: 15)
        nameLabel.textColor = .cream
        wishLabel.font = Appearance.gillSansFont(with: .caption1, pointSize: 30)
        wishLabel.textColor = .brownRed
        
        backgroundColor = .clear
        
    }

}
