//
//  AppDelegate.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 7/30/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import UIKit

import Swinject
import GoELinkModel
import GoELinkViewModel
import GoELinkView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var container: Container {
        let container = Container()
        
        // Models
        container.register(Networking.self) { _ in Network() }
        container.register(ContactServicing.self) { r in ContactService(network: r.resolve(Networking.self)!) }
        
        // View models
        container.register(ContactListTableViewModeling.self) { r in
            let viewModel = ContactListTableViewModel(contactService: r.resolve(ContactServicing.self)!, network: r.resolve(Networking.self)!)
            viewModel.contactDetailViewModel = r.resolve(ContactDetailViewModelModifiable.self)!
            return viewModel
            }.inObjectScope(.Container)
        container.register(ContactDetailViewModelModifiable.self) { _ in
            ContactDetailViewModel(
                network: container.resolve(Networking.self)!)
            }.inObjectScope(.Container)
        container.register(ContactDetailViewModeling.self) { r in
            r.resolve(ContactDetailViewModelModifiable.self)!
        }
        
        // Views
        container.registerForStoryboard(ContactListTableViewController.self) { r, c in
            c.viewModel = r.resolve(ContactListTableViewModeling.self)!
        }
        container.registerForStoryboard(ContactDetailViewController.self) { r, c in
            c.viewModel = r.resolve(ContactDetailViewModeling.self)!
        }
        
        return container
    }



//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
//        let splitViewController = self.window!.rootViewController as! UISplitViewController
//        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
//        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
//        splitViewController.delegate = self
//        return true
//    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        self.window = window
        
        let bundle = NSBundle(forClass: ContactListTableViewController.self)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
//        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
//            if let topAsDetailController = secondaryAsNavController.topViewController as? ContactDetailViewController {
//                if topAsDetailController.detailItemViewModel == nil {
//                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//                    return true
//                }
//            }
//        }
        return false
    }

}

