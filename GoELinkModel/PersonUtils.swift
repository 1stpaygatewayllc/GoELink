//
//  PersonUtils.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/4/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation

/// 👤 A utility class with static functions to handle name formats.
public class PersonUtils: NSObject {
    /**
        Prints the Person name in format - 'firstName surName'
    
        :param: person A person object
    
    */
    public class func firstNameSurNameDisplay(person:Person) -> String {
        
        var result:String
        
        if let surName = person.fullName.surName as String? {
            result = person.fullName.firstName + " " + surName
        } else {
            result = person.fullName.firstName
        }
        
        return result
        
    }
    
    /**
        Prints the Person name in format - 'surName, firstName'
    
        :param: person A person object
    
    */
    public class func surNameFirstNameDisplay(person:Person) -> String {
        
        var result:String
        
        if let surName = person.fullName.surName as String? {
            result = surName + ", " + person.fullName.firstName
        } else {
            result = person.fullName.firstName
        }
        
        return result
        
    }

    
}