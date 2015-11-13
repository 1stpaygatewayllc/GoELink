//
//  Person.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 7/30/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import Foundation

/// A struct to store the data for a Person's name (M)
struct PersonName {
    
    var firstName :String
    var surName :String?  // ? = optional value. surName could be nil
    
    /**
        Initializes a personName with a single first name
    
        :param: firstName A person's first name
    
    */
    init (firstName:String) {
        self.firstName = firstName
    }
    
    /**
    
        Initializes a personName with a first name and last name
    
        :param: firstName A person's first name
        :param: surName A person's surname
    
    */
    init (firstName:String, surName: String?) {
        self.firstName = firstName
        self.surName = surName!
    }
}


/// A class to hold a Person object (M)
public class Person {
    
    /// A person's full name
    var fullName: PersonName
    
    /**
        Initializes a person with a single first name
    
        :param: firstName A person's first name
    
    */
    init(firstName:String) {
        self.fullName = PersonName(firstName: firstName)
    }
    
    /**
        Initializes a person with a first name and last name
    
        :param: firstName A person's first name
        :param: surName A person's surname
    
    */
    init(firstName:String, surName:String?) {
        self.fullName = PersonName(firstName: firstName, surName: surName!)
//        print("\(self.fullName) initialized")
    }
    
    deinit {
        // perform the deinitialization
//        print("\(self.fullName) deinitialized")
    }
}
