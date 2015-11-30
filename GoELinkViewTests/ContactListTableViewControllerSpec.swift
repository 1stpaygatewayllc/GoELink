//
//  ContactListTableViewControllerSpec.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 11/30/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Quick
import Nimble
import ReactiveCocoa
import GoELinkViewModel
@testable import GoELinkView

class ContactListTableViewControllerSpec: QuickSpec {
    class MockViewModel: ContactListTableViewModeling {
        let cellModels = AnyProperty(MutableProperty<[ContactListTableViewCellModeling]>([]))
        let searching = AnyProperty(ConstantProperty<Bool>(false))
        let errorMessage = AnyProperty(ConstantProperty<String?>(nil))
        var loadNextPage: Action<(), (), NoError> = Action { SignalProducer.empty }
        
        var startSearchCallCount = 0
        
        func startSearch() {
            startSearchCallCount++
        }
        
        func selectCellAtIndex(index: Int) {
        }
    }
    
    override func spec() {
        it("starts searching images when the view is about to appear at the first time.") {
            let viewModel = MockViewModel()
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: ContactListTableViewController.self))
            let viewController = storyboard.instantiateViewControllerWithIdentifier("ContactListTableViewController") as! ContactListTableViewController
            viewController.viewModel = viewModel
            
            expect(viewModel.startSearchCallCount) == 0
            viewController.viewWillAppear(true)
            expect(viewModel.startSearchCallCount) == 1
            viewController.viewWillAppear(true)
            expect(viewModel.startSearchCallCount) == 1
        }
    }
}

