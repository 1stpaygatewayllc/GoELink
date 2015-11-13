//
//  ContactListTableViewCellModel.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa
import GoELinkModel

// Inherits NSObject to use rac_willDeallocSignal.
public final class ContactListTableViewCellModel: NSObject, ContactListTableViewCellModeling {
    public let objectId: AnyProperty<String>
    public let first_name: AnyProperty<String>
    public let last_name: AnyProperty<String>
    
    private let network: Networking
    private let profileURL: AnyProperty<String>
    private var profileImage: UIImage?
    
    var newContactEntity: ContactEntity = ContactEntity()
    
    internal init(contact: ContactEntity, network: Networking) {
        objectId = newContactEntity.objectId
        first_name = newContactEntity.first_name
        last_name = newContactEntity.last_name
        profileURL = newContactEntity.profileURL
        
        self.network = network

        
        super.init()
    }
    
    public func getProfileImage() -> SignalProducer<UIImage?, NoError> {
        if let profileImage = self.profileImage {
            return SignalProducer(value: profileImage).observeOn(UIScheduler())
        }
        else {
            let imageProducer = network.requestImage(profileURL)
                .takeUntil(self.racutil_willDeallocProducer)
                .on(next: { self.profileImage = $0 })
                .map { $0 as UIImage? }
                .flatMapError { _ in SignalProducer<UIImage?, NoError>(value: nil) }
            
            return SignalProducer(value: nil)
                .concat(imageProducer)
                .observeOn(UIScheduler())
        }
    }
}
