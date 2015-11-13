//
//  ContactLocalStorageService.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/9/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation

class ContactLocalStorageService : ContactServiceAPI {
    
    enum LocalStorageError: ErrorType {
        case FileReadNoError
        case FileDoesNotExist
        case FileReadPermissionDenied
        case FileEncodingIncompatibility
    }
    
    /**
        Fetches a list of Contacts from designated source or endpoint
    
        :param: completion An enum containing a Success([Person]) or Failure(NSError) .
    
    */
    


    func fetchAll(completion: (DataListResult<Person>) -> Void) throws -> ErrorType {
        print("retrieving data from local storage")

        
        guard let contactsDataURL: NSURL = NSBundle.mainBundle().URLForResource("contacts", withExtension: "json") else {
            throw LocalStorageError.FileDoesNotExist
        }
        
        guard let jsonData: NSData = NSData(contentsOfURL: contactsDataURL) else {
            throw LocalStorageError.FileReadPermissionDenied
        }
        
        do {
            let jsonDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSDictionary

            if let contactsJSON = jsonDict.valueForKeyPath("contacts") as? [NSDictionary] {
                let contacts = contactsJSON.map { self.parseContact($0) }
                completion(DataListResult.Success(contacts))
//                return
            }
            
        } catch {
            throw LocalStorageError.FileEncodingIncompatibility
        }
        
        return LocalStorageError.FileReadNoError

    }

    /**
    Parses a contact
    
    :param: personDict A dictionary of person data
    
    :returns: A person object
    
    */
    
    func parseContact(personDict: NSDictionary) -> Person {
        
        var newPerson:Person
        let firstName = personDict.valueForKeyPath("firstName") as? String
        let surName = personDict.valueForKeyPath("surName") as? String
        
        if surName != nil
        {
            newPerson = Person(firstName: firstName!, surName: surName)
        } else {
            newPerson = Person(firstName: firstName!)
        }
        
        return newPerson
        
    }

    
}



