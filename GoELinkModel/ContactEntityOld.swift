//
//  PersonEntity.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Himotoki

public struct ContactEntityOld {
    public let objectId: String
    public let first_name: String
    public let last_name: String
    public let profileURL: String

}

// MARK: Decodable
extension ContactEntityOld: Decodable {
    public static func decode(e: Extractor) -> ContactEntityOld? {
        return build(ContactEntityOld.init)(
            e <| "objectId",
            e <| "first_name",
            e <| "last_name",
            e <| "profileURL"
        )
    }
}

