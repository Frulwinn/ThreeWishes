//
//  Appearance.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/20/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

enum Appearance {
    
    static func gillSansFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "Gill Sans", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    static func setAppearance() {
        //navigation bar
        UINavigationBar.appearance().barTintColor = .deepRed
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cream, NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 25)!]
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        
        //bar button items
        UIBarButtonItem.appearance().tintColor = .cream
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.cream], for: .normal)
        
        UITextField.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.05)
        UITextField.appearance().textColor = .brownRed
        UITextField.appearance().layer.cornerRadius = 4
        UITextField.appearance().layer.borderColor = .none
    }
    
    static func style(button: UIButton) {
        button.titleLabel?.font = Appearance.gillSansFont(with: .body, pointSize: 17)
        
    }
}
