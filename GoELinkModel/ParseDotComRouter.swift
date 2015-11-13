//
//  Router.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 8/24/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation
import Alamofire

public enum ParseDotComRouter: URLRequestConvertible {
    static let baseURLString = "https://api.parse.com"
    static var OAuthToken: String?
    static let maxContactsPerPage = 50
    
    case ReadAllContacts
//    case CreateContact([String: AnyObject])
//    case ReadContact(String)
//    case UpdateContact(String, [String: AnyObject])
//    case DestroyContact(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadAllContacts:
            return .GET
//        case .CreateContact:
//            return .POST
//        case .ReadContact:
//            return .GET
//        case .UpdateContact:
//            return .PUT
//        case .DestroyContact:
//            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadAllContacts:
            return "1/classes/Contacts"
//        case .CreateContact:
//            return "1/classes/Contacts"
//        case .ReadContact(let fullName):
//            return "1/classes/Contacts/\(fullName)"
//        case .UpdateContact(let fullName, _):
//            return "1/classes/Contacts/\(fullName)"
//        case .DestroyContact(let fullName):
//            return "1/classes/Contacts/\(fullName)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: ParseDotComRouter.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = ParseDotComRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        /// Define the custom Parse.com headers (includes credential information to allow us to access cloud based app
        /// Look to store this info in cocoapod keys for future enhancement.
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("maHHrbix1jAoD29EtPwQ8shPyBchbpoUkne7YrYy", forHTTPHeaderField: "X-Parse-Application-Id")
        mutableURLRequest.setValue("6pA5XFRVQJqJgaBi54lMxJ4j32mQ31EQBSLlGw9R", forHTTPHeaderField: "X-Parse-REST-API-Key")

        
        switch self {
//        case .CreateContact(let parameters):
//            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
//        case .UpdateContact(_, let parameters):
//            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}