//
//  ContactTableViewCellModeling.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa
import enum Result.NoError

public protocol ContactListTableViewCellModeling {
    var objectId: String { get }
    var first_name: String { get }
    var last_name: String { get }
    
    func getProfileImage() -> SignalProducer<UIImage?, NoError>
}