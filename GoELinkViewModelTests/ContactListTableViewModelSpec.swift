//
//  ContactListTableViewModelSpec.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 11/30/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Quick
import Nimble
import ReactiveCocoa
@testable import GoELinkModel
@testable import GoELinkViewModel

class ContactListTableViewModelSpec: QuickSpec {
    // MARK: Stub

    
    class StubContactService: ContactServicing {
        func fetchAllContacts(nextPageTrigger trigger: SignalProducer<(), NoError>) -> SignalProducer<ResponseEntity, NetworkError> {
            return SignalProducer { observer, disposable in
                observer.sendNext(dummyResponse)
                observer.sendCompleted()
                }
                .observeOn(QueueScheduler())
        }
    }
    
    class StubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : AnyObject]?) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
        
        func requestImage(url: String) -> SignalProducer<UIImage, NetworkError> {
            return SignalProducer.empty
        }
        
        func requestJSONWithRoute(route: ParseDotComRouter) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
    }
    
    // MARK: Spec
    override func spec() {
        var viewModel: ContactListTableViewModel!
        beforeEach {
            viewModel = ContactListTableViewModel(contactService: StubContactService(), network: StubNetwork())
        }
        describe("Contact Fetch") {
            it("eventually sets cellModels property after the fetch.") {
                var cellModels: [ContactListTableViewCellModeling]? = nil
                viewModel.cellModels.producer
                    .on(next: { cellModels = $0 })
                    .start()
                viewModel.startSearch()
                
                expect(cellModels).toEventuallyNot(beNil())
                expect(cellModels?.count).toEventually(equal(2))
                expect(cellModels?[0].objectId).toEventually(equal("10000"))
                expect(cellModels?[1].objectId).toEventually(equal("10001"))
            }
            it("sets cellModels property on the main thread.") {
                var onMainThread = false
                viewModel.cellModels.producer
                    .on(next: { _ in onMainThread = NSThread.isMainThread() })
                    .start()
                viewModel.startSearch()
                
                expect(onMainThread).toEventually(beTrue())
            }
        }
    }
}
