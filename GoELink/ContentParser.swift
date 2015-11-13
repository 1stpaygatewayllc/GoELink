//
//  ContentParser.swift
//  BrewMobile
//
//  Created by Ágnes Vásárhelyi on 19/08/14.
//  Copyright (c) 2014 Ágnes Vásárhelyi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

// MARK: JSONDecodable

protocol JSONDecodable {
    static func decode(json: JSON) -> Result<Self, NSError>
}

// MARK: JSONEncodable

protocol JSONEncodable {
    static func encode(object: Self) -> Result<AnyObject, NSError>
}

//typealias PhaseArray = [BrewPhase]

class ContentParser {
    class func parseResponseEntity(responseJSON: JSON) -> ResponseEntity {
        return ResponseEntity.decode(responseJSON).value!
    }
    
    class func parseContactEntity(contactJSON: JSON) -> ContactEntity {
        return ContactEntity.decode(contactJSON).value!
    }
    
//    class func formatDate(dateString: String) -> String {
//        if dateString.characters.count > 0 {
//            let isoDateFormatter = ISO8601DateFormatter()
//            let formattedDate = isoDateFormatter.dateFromString(dateString)
//            let dateStringFormatter = NSDateFormatter()
//            dateStringFormatter.dateFormat = "HH:mm"
//            let formattedDateString = dateStringFormatter.stringFromDate(formattedDate!)
//            
//            return formattedDateString
//        }
//        return ""
//    }

}
