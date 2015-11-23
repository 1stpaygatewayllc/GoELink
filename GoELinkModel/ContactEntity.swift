//
//  ContactEntity.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/24/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//
import Foundation
import ReactiveCocoa
import Result
import SwiftyJSON


public func == (left: ContactEntity, right: ContactEntity) -> Bool {
    
    return (left.first_name.value == right.first_name.value) &&
        (left.last_name.value == right.last_name.value) &&
        (left.objectId.value == right.objectId.value)
}


final public class ContactEntity: Equatable, JSONDecodable, JSONEncodable  {

    public var objectId: AnyProperty<String> { return AnyProperty(_objectId) }
    public var first_name: AnyProperty<String> { return AnyProperty(_first_name) }
    public var last_name: AnyProperty<String> { return AnyProperty(_last_name) }
    public var profileURL: AnyProperty<String> { return AnyProperty(_profileURL) }
    
//    public var objectId: MutableProperty<String>
//    public var first_name: MutableProperty<String>
//    public var last_name: MutableProperty<String>
//    public var profileURL: MutableProperty<String>
    
    var _objectId: MutableProperty<String>
    var _first_name: MutableProperty<String>
    var _last_name: MutableProperty<String>
    var _profileURL: MutableProperty<String>
    
    public init() {
        _objectId = MutableProperty<String>("")
        _first_name = MutableProperty<String>("")
        _last_name = MutableProperty<String>("")
        _profileURL = MutableProperty<String>("")
    }
    
    init(first_name: String, last_name: String, objectId: String, profileURL: String) {
        _objectId = MutableProperty<String>(objectId)
        _first_name = MutableProperty<String>(first_name)
        _last_name = MutableProperty<String>(last_name)
        _profileURL = MutableProperty<String>(profileURL)

    }
    
    init(first_name: MutableProperty<String>,
        last_name: MutableProperty<String>,
        objectId: MutableProperty<String>,
        profileURL: MutableProperty<String>) {
        _objectId = objectId
        _first_name = first_name
        _last_name = last_name
        _profileURL = profileURL
    }
    

    // MARK: JSONDecodable
    
    public class func decode(json: JSON) -> Result<ContactEntity, NSError> {
        return Result(ContactEntity(
            first_name: json["first_name"].stringValue,
            last_name: json["last_name"].stringValue,
            objectId: json["objectId"].stringValue,
            profileURL: json["profileURL"].stringValue
            )
        )
    }
    
    // MARK: JSONEncodable
    
    public class func encode(object: ContactEntity) -> Result<AnyObject, NSError> {
        var contact = [String: AnyObject]()
        
        contact["first_name"] = object.first_name.value
        contact["last_name"] = object.last_name.value
        contact["objectId"] = object.objectId.value
        contact["profileURL"] = object.profileURL.value
        
        return Result(contact)
    }

}