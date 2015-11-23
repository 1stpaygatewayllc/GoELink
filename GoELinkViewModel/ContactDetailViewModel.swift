//
//  ImageDetailViewModel.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import ReactiveCocoa
import GoELinkModel

public final class ContactDetailViewModel: ContactDetailViewModeling {
    public var objectId: AnyProperty<String?> { return AnyProperty(_objectId) }
    public var firstNameText: AnyProperty<String?> { return AnyProperty(_firstNameText) }
    public var lastNameText: AnyProperty<String?> { return AnyProperty(_lastNameText) }
    
//    public var pageImageSizeText: AnyProperty<String?> { return AnyProperty(_pageImageSizeText) }
//    public var tagText: AnyProperty<String?> { return AnyProperty(_tagText) }
//    public var usernameText: AnyProperty<String?> { return AnyProperty(_usernameText) }
//    public var viewCountText: AnyProperty<String?> { return AnyProperty(_viewCountText) }
//    public var downloadCountText: AnyProperty<String?> { return AnyProperty(_downloadCountText) }
//    public var likeCountText: AnyProperty<String?> { return AnyProperty(_likeCountText) }
//    public var image: AnyProperty<UIImage?> { return AnyProperty(_image) }
    
    private let _objectId = MutableProperty<String?>(nil)
    private let _firstNameText = MutableProperty<String?>(nil)
    private let _lastNameText = MutableProperty<String?>(nil)
//    private let _pageImageSizeText = MutableProperty<String?>(nil)
//    private let _tagText = MutableProperty<String?>(nil)
//    private let _usernameText = MutableProperty<String?>(nil)
//    private let _viewCountText = MutableProperty<String?>(nil)
//    private let _downloadCountText = MutableProperty<String?>(nil)
//    private let _likeCountText = MutableProperty<String?>(nil)
//    private let _image = MutableProperty<UIImage?>(nil)
    
    internal var locale = NSLocale.currentLocale() // For testing.
    private var contactEntities = [ContactEntity]()
    private var currentContactIndex = 0
    private var (stopSignalProducer, stopSignalObserver) = SignalProducer<(), NoError>.buffer()
    
    private let network: Networking
//    private let externalAppChannel: ExternalAppChanneling

//    public init(network: Networking, externalAppChannel: ExternalAppChanneling) {
//        self.network = network
//        self.externalAppChannel = externalAppChannel
//    }
    
    public init(network: Networking) {
        self.network = network
    }
    
//    public func openImagePage() {
//        if let currentImageEntity = currentImageEntity {
//            externalAppChannel.openURL(currentImageEntity.pageURL)
//        }
//    }
    
    private var currentContactEntity: ContactEntity? {
        return contactEntities.indices.contains(currentContactIndex) ? contactEntities[currentContactIndex] : nil
    }
}

extension ContactDetailViewModel: ContactDetailViewModelModifiable {
    public func update(contactEntities: [ContactEntity], atIndex index: Int) {
        stopSignalObserver.sendNext(())
        (stopSignalProducer, stopSignalObserver) = SignalProducer<(), NoError>.buffer()
        
        self.contactEntities = contactEntities
        currentContactIndex = index
        let contactEntity = currentContactEntity
        
        self._objectId.value = contactEntity?.objectId.value
        self._firstNameText.value = contactEntity?.first_name.value
        self._lastNameText.value = contactEntity?.last_name.value
        
//        self._usernameText.value = contactEntity?.first_name
//        self._pageImageSizeText.value = imageEntity.map { "\($0.pageImageWidth) x \($0.pageImageHeight)" }
//        self._tagText.value = imageEntity.map { $0.tags.joinWithSeparator(", ") }
//        self._viewCountText.value = imageEntity.map { formatInt64($0.viewCount) }
//        self._downloadCountText.value = imageEntity.map { formatInt64($0.downloadCount) }
//        self._likeCountText.value = imageEntity.map { formatInt64($0.likeCount) }
        
//        _image.value = nil
//        if let contactEntity = contactEntity {
//            _image <~ network.requestImage(contactEntity.imageURL)
//                .takeUntil(stopSignalProducer)
//                .map { $0 as UIImage? }
//                .flatMapError { _ in SignalProducer<UIImage?, NoError>(value: nil) }
//                .observeOn(UIScheduler())
//        }
    }
    
    private func formatInt64(value: Int64) -> String {
        return NSNumber(longLong: value).descriptionWithLocale(locale)
    }
    
    // This method can be used if you add next and previsou buttons on image detail view
    // to display the next or previous image.
//    public func updateIndex(index: Int) {
//        update(imageEntities, atIndex: index)
//    }
}
