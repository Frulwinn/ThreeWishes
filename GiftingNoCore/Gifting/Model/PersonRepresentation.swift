//
//  Person.swift
//  Gifting
//
//  Created by Lambda_School_Loaner_34 on 3/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

public struct PersonRepresentation: Codable, Equatable {
    
    public var name: String
    public var birthday: Date
    public var firstChoice: String?
    public var secondChoice: String?
    public var thirdChoice: String?
    public var identifier: String
    public var isBoughtFirst: Bool?
    public var isBoughtSecond: Bool?
    public var isBoughtThird: Bool?
    
}

func ==(lhs: PersonRepresentation, rhs: Person) -> Bool {
    return rhs.name == lhs.name &&
        rhs.birthday == lhs.birthday &&
        rhs.firstChoice == lhs.firstChoice &&
        rhs.secondChoice == lhs.secondChoice &&
        rhs.thirdChoice == lhs.thirdChoice &&
        rhs.identifier == lhs.identifier &&
        rhs.isBoughtFirst == lhs.isBoughtFirst &&
        rhs.isBoughtSecond == lhs.isBoughtSecond &&
        rhs.isBoughtThird == lhs.isBoughtThird
    
}

func ==(lhs: Person, rhs: PersonRepresentation) -> Bool {
    return rhs == lhs
}

func !=(lhs: PersonRepresentation, rhs: Person) -> Bool {
    return !(rhs == lhs)
}

func !=(lhs: Person, rhs: PersonRepresentation) -> Bool {
    return rhs != lhs
}
