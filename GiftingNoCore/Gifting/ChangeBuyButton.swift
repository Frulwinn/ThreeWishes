//
//  ChangeBuyButton.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 4/24/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class ChangeBuyButton: UIButton {
    
    var isBought = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    @objc func initButton() {
        //layer.borderWidth
        //layer.borderColor
        //layer.cornerRadius = frame.size.height /2
        setTitleColor(UIColor.brownRed, for: .normal)
        addTarget(self, action: #selector(ChangeBuyButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isBought)
    }
    
    func activateButton(bool:Bool) {
        isBought = bool
        
        //let color = bool ? UIColor.deepRed : .clear
        let title = bool ? "bought" : "buy"
        //let titleColor = bool ? UIColor.cream : UIColor.brownRed
        
        
        setTitle(title, for: .normal)
        //setTitleColor(titleColor, for: .normal)
        //backgroundColor = color
    }
}
