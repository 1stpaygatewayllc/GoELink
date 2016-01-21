//
//  ContactServicing.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa

public protocol ContactServicing {
    func fetchAllContacts(nextPageTrigger trigger: SignalProducer<(), NoError>) -> SignalProducer<ResponseEntity, NetworkError>
    
    func updateContact(key: String, parameters: Dictionary<String, AnyObject>) -> SignalProducer<Bool, NetworkError>
    
}