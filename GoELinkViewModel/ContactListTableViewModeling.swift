//
//  ContactTableViewModeling.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/3/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import ReactiveCocoa

public protocol ContactListTableViewModeling {
    var cellModels: AnyProperty<[ContactListTableViewCellModeling]> { get }
    var searching: AnyProperty<Bool> { get }
    var errorMessage: AnyProperty<String?> { get }
    
    func startSearch()
//    var loadNextPage: Action<(), (), NoError> { get }
    
    func selectCellAtIndex(index: Int)
}
