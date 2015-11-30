//
//  ContactListTableViewCellSpec.swift
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

class ContactListTableViewCellSpec: QuickSpec {
    class MockViewModel: ContactListTableViewCellModeling {
        let objectId: UInt64 = ""
        let first_name = ""
        let last_name = ""
        
        var getPreviewImageStarted = false
        
        func getPreviewImage() -> SignalProducer<UIImage?, NoError> {
            return SignalProducer<UIImage?, NoError> { observer, _ in
                self.getPreviewImageStarted = true
                observer.sendCompleted()
            }
        }
    }
    
    override func spec() {
        it("starts getPreviewImage signal producer when its view model is set.") {
            let viewModel = MockViewModel()
            let view = createTableViewCell()
            
            expect(viewModel.getPreviewImageStarted) == false
            view.viewModel = viewModel
            expect(viewModel.getPreviewImageStarted) == true
        }
    }
}

private func createTableViewCell() -> ContactListTableViewCell {
    let bundle = NSBundle(forClass: ContactListTableViewCell.self)
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    let tableViewController = storyboard.instantiateViewControllerWithIdentifier("ContactListTableViewController")
        as! ContactListTableViewController
    return tableViewController.tableView.dequeueReusableCellWithIdentifier("ContactListTableViewCell")
        as! ContactListTableViewCell
}

