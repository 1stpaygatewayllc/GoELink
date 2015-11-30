//
//  AppDelegateSpec.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 11/30/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import Quick
import Nimble
import Swinject
import GoELinkModel
import GoELinkViewModel
import GoELinkView

@testable import GoELink

class AppDelegateSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = AppDelegate().container
        }
        
        describe("Container") {
            it("resolves every service type.") {
                // Models
                expect(container.resolve(Networking.self)).notTo(beNil())
                expect(container.resolve(ContactServicing.self)).notTo(beNil())
                
                // ViewModels
                expect(container.resolve(ContactListTableViewModeling.self))
                    .notTo(beNil())
            }
            it("injects view models to views.") {
                let bundle = NSBundle(forClass: ContactListTableViewController.self)
                let storyboard = SwinjectStoryboard.create(
                    name: "Main",
                    bundle: bundle,
                    container: container)
                let contactListTableViewController = storyboard
                    .instantiateViewControllerWithIdentifier("ContactListTableViewController")
                    as! ContactListTableViewController
                
                let contactDetailViewController = storyboard
                    .instantiateViewControllerWithIdentifier("ContactDetailViewController")
                    as! ContactDetailViewController
                
                expect(contactListTableViewController.viewModel).notTo(beNil())
                expect(contactDetailViewController.viewModel).notTo(beNil())
            }
        }
    }
}