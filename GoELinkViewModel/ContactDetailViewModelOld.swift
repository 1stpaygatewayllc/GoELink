//
//  ContactDetailViewModel.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/4/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation
import GoELinkModel

/// A view model (VM) class for managing the logic of Contact Detail Controller/View (V)
class ContactDetailViewModel:NSObject {
    
    /// A contact
    var contact: Person?
    
    /// A contact's fullName
    var fullNameText: String
    
    
    /**
        Initializes a Contact View Model
    
        :param: contact A person object
    
    */
    init (contact:Person) {
        self.contact = contact
//        self.fullNameText = PersonUtils.surNameFirstNameDisplay(contact)
        self.fullNameText = PersonUtils.firstNameSurNameDisplay(contact)
    }
 
}