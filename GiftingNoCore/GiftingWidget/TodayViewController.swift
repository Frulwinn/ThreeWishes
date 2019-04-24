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
    var person: Person?
    /*
     var symbol: String {
        return "GBP"
    */
    
    //MARK: - Outlets
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var giftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extends widget
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded

    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        // need birthday, name, firstchoice
        
        fetcher.fetchPersonFromServer { (error) in
            if let error = error {
                NSLog("Error fetching current person: \(error)")
                completionHandler(.failed)
                return
            }
            
            guard let person = self.person,
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
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
