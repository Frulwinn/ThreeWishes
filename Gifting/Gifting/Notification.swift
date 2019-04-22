////
////  Notification.swift
////  Gifting
////
////  Created by Lambda_School_Loaner_34 on 3/21/19.
////  Copyright © 2019 Frulwinn. All rights reserved.
////
//
//import UIKit
//import UserNotifications
//
//class Notification {
//    
//    let center = UNUserNotificationCenter.current()
//    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//    if granted {
//    print("Yay!")
//    } else {
//    print("Aww man")
//    }
//    }
//    let date = Date(timeIntervalSinceNow: 3600)
//    let triggerDate = Calendar.current.dateComponents([.month, .day], from: date)
//    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
//    
//    let content = UNMutableNotificationContent()
//    content.title = "Do you want a birthday notification?"
//    content.body = "You might want this"
//    content.badge = 1
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { didAllow, error in
//            if didAllow {
//                
//            } else {
//                
//            }
//        })
//    }
//}
