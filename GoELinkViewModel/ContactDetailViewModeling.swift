//
//  ImageDetailViewModeling.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import ReactiveCocoa
import GoELinkModel

public protocol ContactDetailViewModeling {
    var objectId: AnyProperty<String?> { get }
    var firstNameText: AnyProperty<String?> { get }
    var lastNameText: AnyProperty<String?> { get }
//    var pageImageSizeText: AnyProperty<String?> { get }
//    var tagText: AnyProperty<String?> { get }
//    var usernameText: AnyProperty<String?> { get }
//    var viewCountText: AnyProperty<String?> { get }
//    var downloadCountText: AnyProperty<String?> { get }
//    var likeCountText: AnyProperty<String?> { get }
//    var image: AnyProperty<UIImage?> { get }
    
//    func openImagePage()
}

public protocol ContactDetailViewModelModifiable: ContactDetailViewModeling {
    func update(contactEntities: [ContactEntity], atIndex index: Int)
}
