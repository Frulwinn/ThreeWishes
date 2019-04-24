//
//  Date.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/21/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter
    }
}
