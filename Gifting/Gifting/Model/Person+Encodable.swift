//
//  Person+Encodable.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/19/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

extension Person: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case firstChoice
        case secondChoice
        case thirdChoice
        case identifier
        
    }
    
    public func encode(to encoder: Encoder) throws {
       
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(firstChoice, forKey: .firstChoice)
        try container.encode(secondChoice, forKey: .secondChoice)
        try container.encode(thirdChoice, forKey: .thirdChoice)
        try container.encode(identifier, forKey: .identifier)
    }
}
