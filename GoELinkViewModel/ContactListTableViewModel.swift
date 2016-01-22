//
//  ContactTableViewModel.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa
import GoELinkModel

public final class ContactListTableViewModel: ContactListTableViewModeling {
    public var cellModels: AnyProperty<[ContactListTableViewCellModeling]> { return AnyProperty(_cellModels) }
    public var searching: AnyProperty<Bool> { return AnyProperty(_searching) }
    public var refreshing: AnyProperty<Bool> { return AnyProperty(_refreshing) }
    public var errorMessage: AnyProperty<String?> { return AnyProperty(_errorMessage) }
    
    private let _cellModels = MutableProperty<[ContactListTableViewCellModeling]>([])
    private let _searching = MutableProperty<Bool>(false)
    private let _refreshing = MutableProperty<Bool>(false)
    private let _errorMessage = MutableProperty<String?>(nil)
    
    /// Accepts property injection.
    public var contactDetailViewModel: ContactDetailViewModelModifiable?
    
//    public var loadNextPage: Action<(), (), NoError> {
//        return Action(enabledIf: nextPageLoadable) { _ in
//            return SignalProducer { observer, disposable in
//                if let (_, observer) = self.nextPageTrigger.value {
//                    self._searching.value = true
//                    sendNext(observer, ())
//                }
//            }
//        }
//    }
//    private var nextPageLoadable: AnyProperty<Bool> {
//        return AnyProperty(
//            initialValue: false,
//            producer: searching.producer.combineLatestWith(nextPageTrigger.producer).map { searching, trigger in
//                !searching && trigger != nil
//            })
//    }
    private let nextPageTrigger = MutableProperty<(SignalProducer<(), NoError>, Observer<(), NoError>)?>(nil) // SignalProducer buffer
    
//    private let imageSearch: ImageSearching
    private let contactService: ContactServicing
    private let network: Networking
    
    private var foundContacts = [ContactEntity]()
    
    public init(contactService: ContactServicing, network: Networking) {
        self.contactService = contactService
        self.network = network
    }
    
    public func startSearch() {

        
        _searching.value = true
        nextPageTrigger.value = SignalProducer<(), NoError>.buffer()
        let (trigger, _) = nextPageTrigger.value!
        
        contactService.fetchAllContacts(nextPageTrigger: trigger)
            .map { response in
                (response.results, response.results.map { self.toCellModel($0) })
            }
            .observeOn(UIScheduler())
            .on(next: { contacts, cellModels in
                self.foundContacts = contacts
                self._cellModels.value = cellModels
                self._searching.value = false
            })
//            .on(error: { error in
////                self._errorMessage.value = error.description.value
//            })
            .on(event: { event in
                switch event {
                case .Completed, .Failed, .Interrupted:
                    self.nextPageTrigger.value = nil
                    self._searching.value = false
                default:
                    break
                }
            })
            .start()
    }
    
    public func selectCellAtIndex(index: Int) {
        contactDetailViewModel?.update(foundContacts, atIndex: index)
    }
    
    public func toCellModel(contact: ContactEntity) -> ContactListTableViewCellModeling {
        print("Name: \(contact.first_name.value) \(contact.last_name.value) - ObjectId: \(contact.objectId.value)")
        return ContactListTableViewCellModel(contact: contact, network: self.network) as ContactListTableViewCellModeling
    }
    
    public func updateCellModels(cellModels: [ContactListTableViewCellModeling]) {
        self._refreshing.value = true
        self._cellModels.value = cellModels
    }
    
}

