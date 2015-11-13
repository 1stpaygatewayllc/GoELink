//
//  WebServices.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/9/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Foundation


    
enum DataListResult<T> {
    case Success([T])
    case Failure(ErrorType)
}


protocol ContactServiceAPI {
    func fetchAll(completion: (DataListResult<Person>) -> Void) throws -> ErrorType
}