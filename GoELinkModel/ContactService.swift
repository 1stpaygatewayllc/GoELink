//
//  ContactService.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa
//import Himotoki
import SwiftyJSON

public final class ContactService: ContactServicing {
    private let network: Networking
    
    public init(network: Networking) {
        self.network = network
    }
    
    public func fetchAllContacts(nextPageTrigger trigger: SignalProducer<(), NoError>) -> SignalProducer<ResponseEntity, NetworkError> {
        return SignalProducer { observer, disposable in
            let firstSearch = SignalProducer<(), NoError>(value: ())
            let load = firstSearch.concat(trigger)
//            var parameters = Pixabay.requestParameters
            var loadedContactsCount: Int64 = 0
            
            load.on(next: {
                self.network.requestJSONWithRoute(ParseDotComRouter.ReadAllContacts)
                    .start({ event in
                        switch event {
                        case .Next(let json):
                            print(json)
                            if let response = ContentParser.parseResponseEntity(JSON(json)) as ResponseEntity? {
//                                print(response)
                                observer.sendNext(response)
                                loadedContactsCount += response.results.count
//                                if response.totalCount <= loadedContactsCount || response.results.count < ParseDotComRouter.maxImagesPerPage {
//                                    sendCompleted(observer)
//                                }
                                observer.sendCompleted()
                            }
                            else {
                                observer.sendFailed(.IncorrectDataReturned)
                            }
                        case .Failed(let error):
                            observer.sendFailed(error)
                        case .Completed:
                            break
                        case .Interrupted:
                            observer.sendInterrupted()
                        }
                    })
//                parameters = Pixabay.incrementPage(parameters)
            }).start()
        }
    }
    
    
    public func updateContact(key: String, parameters: Dictionary<String, AnyObject>) -> SignalProducer<Bool, NetworkError> {
        return SignalProducer { observer, disposable in
            let load = SignalProducer<(), NoError>(value: ())
            load.on(next: {
                self.network.requestJSONWithRoute(ParseDotComRouter.UpdateContact(key, parameters))
                    .start({ event in
                        switch event {
                        case .Next(let json):
                            print(json)
//                            if let response = ContentParser.parseResponseEntity(JSON(json)) as ResponseEntity? {
//                                //                                print(response)
////                                observer.sendNext(response)
////                                loadedContactsCount += response.results.count
//                                //                                if response.totalCount <= loadedContactsCount || response.results.count < ParseDotComRouter.maxImagesPerPage {
//                                //                                    sendCompleted(observer)
//                                //                                }
//                                observer.sendCompleted()
//                            }
//                            else {
//                                observer.sendFailed(.IncorrectDataReturned)
//                            }
                            observer.sendNext(true)
                            observer.sendCompleted()
                            
                        case .Failed(let error):
                            observer.sendFailed(error)
                        case .Completed:
                            break
                        case .Interrupted:
                            observer.sendInterrupted()
                        }
                    })
                //                parameters = Pixabay.incrementPage(parameters)
            }).start()
        }
    }
    
}