//
//  Network.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/22/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import ReactiveCocoa
import Alamofire

public final class Network: Networking {
    private let queue = dispatch_queue_create("SwinjectMMVMExample.ExampleModel.Network.Queue", DISPATCH_QUEUE_SERIAL)

    public init() { }
    
    public func requestJSON(url: String, parameters: [String : AnyObject]?) -> SignalProducer<AnyObject, NetworkError> {
        return SignalProducer<AnyObject, NetworkError> { observer, disposable in
            Alamofire.request(.GET, url, parameters: parameters)
                .response(queue: self.queue, responseSerializer: Alamofire.Request.JSONResponseSerializer(options: .AllowFragments)) {(Response) -> Void in
                    switch Response.result {
                    case .Success(let value):
                        observer.sendNext(value)
                        observer.sendCompleted()
                    case .Failure(let error):
                        observer.sendFailed(NetworkError(error: error))
                    }
                }
        }
    }
    
    public func requestJSONWithRoute(route: ParseDotComRouter) -> SignalProducer<AnyObject, NetworkError> {
        return SignalProducer<AnyObject, NetworkError>  { observer, disposable in
            
            print("route.method: \(route.method)")
            print("route.path: \(route.path)")
            print("route.URLRequest.URLString: \(route.URLRequest.URLString)")
            
            Alamofire.request(route)
                .response(queue: self.queue, responseSerializer: Alamofire.Request.JSONResponseSerializer()) {(Response) -> Void in
                    switch Response.result {
                    case .Success(let value):
//                        print(value)
                        observer.sendNext(value)
                        observer.sendCompleted()
                    case .Failure(let error):
                        observer.sendFailed(NetworkError(error: error))
                    }
            }
        }
    }
    
    public func requestImage(url: String) -> SignalProducer<UIImage, NetworkError> {
        return SignalProducer { observer, disposable in
            Alamofire.request(.GET, url)
                .response(queue: self.queue, responseSerializer: Alamofire.Request.dataResponseSerializer()) { (Response) -> Void in
                    switch Response.result {
                    case .Success(let data):
                        guard let image = UIImage(data: data) else {
                            observer.sendFailed(NetworkError.IncorrectDataReturned)
                            return
                        }
                        observer.sendNext(image)
                        observer.sendCompleted()
                    case .Failure(let error):
                        observer.sendFailed(NetworkError(error: error))
                    }
            }
        }
    }
}
