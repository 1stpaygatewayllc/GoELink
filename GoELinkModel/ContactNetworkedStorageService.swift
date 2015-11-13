//
//  ContactNetworkedStorageService.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/17/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct ContactNetworkedStorageService {
    
    func fetchAll(completion: (DataListResult<Person>) -> Void) {

        /// get a handle on the shared network manager.
        let manager:Manager = Alamofire.Manager.sharedInstance
        
        /// make request to remote endpoint
        manager.request(Router.ReadAllContacts)
        .responseJSON { request, response, result in
            
            print(request)
            print(response)
            print(result)
           switch result {
            case .Success(let data):
                let json = JSON(data)
         
                if let contactsJSON: Array<JSON> = json["results"].arrayValue  {
                    let contacts = contactsJSON.map { self.parseContact($0.dictionaryValue) }
                    completion(DataListResult.Success(contacts))
                    return
                }


            case .Failure(_, let error):
                print("Request failed with error: \(error)")
                completion(DataListResult.Failure(error))
            }
            

            
        }
    }
    
    /**
    Parses a contact
    
    :param: personDict A dictionary of person data
    
    :returns: A person object
    
    */
    
    func parseContact(personDict: [String: JSON]) -> Person {
        
        var newPerson:Person
        let firstName = personDict["first_name"]!.string
        let surName = personDict["last_name"]!.string
        
        if surName != nil
        {
            newPerson = Person(firstName: firstName!, surName: surName)
        } else {
            newPerson = Person(firstName: firstName!)
        }
        
        return newPerson
        
    }
}
