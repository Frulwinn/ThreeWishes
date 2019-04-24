//
//  Color+Convenience.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/20/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    static let deepRed = UIColor(133, 20, 20, 1)
    static let brownRed = UIColor(64, 1, 1, 1)
    static let cream = UIColor(205, 163, 118, 1)
    static let pale = UIColor(238, 202, 171, 1)
    static let tan = UIColor(131, 101, 74, 1)
}
