//
//  ImageDetailViewModel.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import ReactiveCocoa
import GoELinkModel
import enum Result.NoError

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
    private var (stopSignalProducer, stopSignalObserver) = SignalProducer<(), NoError>.buffer(0)
    
    private let network: Networking
    private let contactService: ContactServicing
//    private let externalAppChannel: ExternalAppChanneling

//    public init(network: Networking, externalAppChannel: ExternalAppChanneling) {
//        self.network = network
//        self.externalAppChannel = externalAppChannel
//    }
    
    public init(contactService: ContactServicing, network: Networking) {
        self.contactService = contactService
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
    
    public func submitWithParameters(objectId: String, firstname: String, lastname: String, complete completeBlock:(Bool) -> ()) {
//        let delayInSeconds: Double = 1.0
        self._objectId.value = objectId
        self._firstNameText.value = firstname
        self._lastNameText.value = lastname
        
        let contactEntity  = ContactEntity(first_name: firstname, last_name: lastname, objectId: objectId, profileURL: "")
        let cellViewModel = ContactListTableViewCellModel(contact: contactEntity, network: network)

        let tableViewModel = ContactListTableViewModel.init(contactService: contactService, network: network)
    
        
        var modifiedCellModels = contactEntities.map { tableViewModel.toCellModel($0)}

        modifiedCellModels[currentContactIndex] = cellViewModel

        tableViewModel.updateCellModels(modifiedCellModels)
      
        
        let parameters = ["first_name":"\(firstname)", "last_name":"\(lastname)"]
        

//        contactEntities[currentContactIndex].objectId = objectId
//        contactEntities[currentContactIndex].first_name = ""
        
        
//        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
//        dispatch_after(popTime, dispatch_get_main_queue(), {
//            let success = firstname != "" && lastname != ""
//            completeBlock(success)
//        })
        

        
        print("currentContactIndex: \(currentContactIndex)")
        print("contactEntities Count: \(self.contactEntities.count)")
        
        
        print("Running update...")
        let result = self.contactService.updateContact(objectId, parameters: parameters)
        
        let success = (result.first()?.value)! as Bool
        print("Result: \(success)")
        
//        update(self.contactEntities, atIndex: currentContactIndex)
        
        completeBlock(success)
    }
}

extension ContactDetailViewModel: ContactDetailViewModelModifiable {
    public func update(contactEntities: [ContactEntity], atIndex index: Int) {
        stopSignalObserver.sendNext(())
        (stopSignalProducer, stopSignalObserver) = SignalProducer<(), NoError>.buffer(0)
        
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

//class DummySubmitService {
//    func submitWithFirstNameLastName(firstname: String, lastname: String, complete completeBlock:(Bool) -> ()) {
//        let delayInSeconds: Double = 1.0
//        
//        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
//        dispatch_after(popTime, dispatch_get_main_queue(), {
//            let success = firstname != "" && lastname != ""
//            completeBlock(success)
//        })
//    }
//}
