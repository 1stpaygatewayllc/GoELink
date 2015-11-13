//
//  ResponseEntity.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/24/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import SwiftyJSON


final public class ResponseEntity: JSONDecodable  {
    
    let results: [ContactEntity]
    
    
    init(results:[ContactEntity]) {
        self.results = results
    }
    
    // MARK: JSONDecodable
    
    class func decode(json: JSON) -> Result<ResponseEntity, NSError> {
        
        if let contactsJSON: Array<JSON> = json["results"].arrayValue  {
            let contacts = contactsJSON.map { self.parseContact($0.dictionaryValue) }
            return Result(ResponseEntity(results: contacts))
        }
    }
    
    /**
    Parses a contact
    
    :param: personDict A dictionary of person data
    
    :returns: A person object
    
    */
    
    class func parseContact(contactDict: [String: JSON]) -> ContactEntity {
        
        let first_name = contactDict["first_name"]!.string
        let last_name = contactDict["last_name"]!.string
        let objectId = contactDict["objectId"]!.string
        let profileURL = contactDict["profileURL"]!.string
        
        return ContactEntity(first_name: first_name!, last_name: last_name!, objectId: objectId!, profileURL: profileURL!)
        
    }
    
}