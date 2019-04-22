//
//  ChangeBuyButton.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 4/22/19.
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
        //setTitle("buy", for: .normal)
        addTarget(self, action: #selector(ChangeBuyButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isBought)
    }
    
    func activateButton(bool:Bool) {
        isBought = bool
        
        //let color = bool ? Colors.red : .clear
        //let titleColor = bool ? .white: Colors.red
        let title = bool ? "Buy" : "Bought"
        
        setTitle(title, for: .normal)
        //setTitleColor(titleColor, for: .normal)
        //backgroundColor = color
    }
}
