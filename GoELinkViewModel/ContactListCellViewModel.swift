//
//  ContactListCellViewModel.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 8/19/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import UIKit
import GoELinkModel

protocol ContactTextCellDataSource {
    var fullName: String { get }
}

protocol ContactTextCellDelegate {
    static func fullNameDisplay(person:Person) -> String
    
    var textColor: UIColor { get }
    var font: UIFont { get }
}

extension ContactTextCellDelegate {
    
    
    var textColor: UIColor {
        return .blackColor()
    }
    
    var font: UIFont {
        return .systemFontOfSize(17)
    }
}

struct ContactListCellViewModel: ContactTextCellDataSource {
    var fullName: String
}

extension ContactListCellViewModel: ContactTextCellDelegate {
    
    static func fullNameDisplay(person: Person) -> String {

//        return PersonUtils.firstNameSurNameDisplay(person)
                return PersonUtils.surNameFirstNameDisplay(person)
    }
    
    init (person: Person) {
        let fullName:String = ContactListCellViewModel.fullNameDisplay(person)
//        print(fullName)
        self.fullName = fullName
    }
}

