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
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var giftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
