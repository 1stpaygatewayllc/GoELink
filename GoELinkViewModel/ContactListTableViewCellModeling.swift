//
//  ContactTableViewCellModeling.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa

public protocol ContactListTableViewCellModeling {
    var objectId: AnyProperty<String> { get }
    var first_name: AnyProperty<String> { get }
    var last_name: AnyProperty<String> { get }
    
    func getProfileImage() -> SignalProducer<UIImage?, NoError>
}