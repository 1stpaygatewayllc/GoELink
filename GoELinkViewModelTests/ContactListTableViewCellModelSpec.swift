//
//  ContactListTableViewCellModelSpec.swift
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

class ContactListTableViewCellModelSpec: QuickSpec {
    
    
    class StubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : AnyObject]?) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
        
        func requestImage(url: String) -> SignalProducer<UIImage, NetworkError> {
            return SignalProducer(value: image1x1).observeOn(QueueScheduler())
        }
        
        func requestJSONWithRoute(route: ParseDotComRouter) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
    }
    
    class ErrorStubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : AnyObject]?) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
        
        func requestImage(url: String) -> SignalProducer<UIImage, NetworkError> {
            return SignalProducer(error: .NotConnectedToInternet)
        }
        
        func requestJSONWithRoute(route: ParseDotComRouter) -> SignalProducer<AnyObject, NetworkError> {
            return SignalProducer.empty
        }
    }
    
    override func spec() {
        
        var viewModel: ContactListTableViewCellModel!
        beforeEach {
            viewModel = ContactListTableViewCellModel(contact: dummyResponse.results[0], network: StubNetwork())
        }
        
         describe("Constant values") {
            it("sets id.") {
                expect(viewModel.objectId).toEventually(equal("QdQGHXs016"))
            }
            it("formats tag and page image size texts.") {
                let viewModel = ContactListTableViewCellModel(contact: dummyResponse.results[0], network: StubNetwork())
                
                expect(viewModel.first_name).toEventually(equal("Bryan"))
                expect(viewModel.last_name).toEventually(equal("Hudson"))
            }
        }
    }
}
