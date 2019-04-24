//
//  TodayViewController.swift
//  GiftingWidget
//
//  Created by Lambda_School_Loaner_34 on 4/24/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

//Don't forget to say no to Rquire Only App - Extension Safe API in widget target build settings
class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: - Properties
    let fetcher = PersonController()
    
    //shared user defaults between app and widget
    let sharedUserDefaults = UserDefaults(suiteName: "group.com.Frulwinn.Gifting")!
    var person: Person? {
        didSet {
            //    return sharedUserDefaults.string(forKey: "LastViewedPerson")
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var giftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        birthdayLabel.textColor = .cream
        nameLabel.textColor = .brownRed
        giftLabel.textColor = .cream
        view.backgroundColor = .deepRed
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
   
        
        guard let identifier = sharedUserDefaults.string(forKey: "LastViewedPerson"),
        
            let person = fetcher.fetchOnePersonFromServer(identifier: identifier , context: CoreDataStack.shared.mainContext),
                let birthday = person.birthday else {
                completionHandler(.failed)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            
            DispatchQueue.main.async {
                self.birthdayLabel.text = dateFormatter.string(from: birthday)
                self.nameLabel.text = person.name
                self.giftLabel.text = person.firstChoice
            }
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
