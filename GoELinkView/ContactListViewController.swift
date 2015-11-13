//
//  ContactListViewController.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 7/30/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import UIKit

/// A controller class for displaying content and handling events (V)
class ContactListViewController: UITableViewController {

    var contactDetailViewController: ContactDetailViewController? = nil
    var objects = [AnyObject]()
    
    
    @IBOutlet var viewModel: ContactListViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /// hide the button for the interim as data is coming from JSON file
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        /// hide the button for the interim as data is coming from JSON file
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.contactDetailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ContactDetailViewController
        }
        
        
        /// the ViewModel fetches the available contacts and reloads the table data
        viewModel.fetchContacts(completion:{(success:Bool?, errorMsg:String?) in
            
            if (success == true) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
                alertController.addAction(okAction)
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func insertNewObject(sender: AnyObject) {
        
//        if (beatlesCount < beatles.count) {
//            objects.insert(beatles[beatlesCount], atIndex: 0)
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            beatlesCount++
//        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = viewModel.fetchContactForItemAtIndexPath(indexPath)
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ContactDetailViewController
                
                /// get a details ViewModel object for the selected person.
                controller.detailItemViewModel = ContactDetailViewModel(contact: object)
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        /// Note how the ViewModel is responsible for returning the value count of items
        return viewModel.numberOfItemsInSection(section)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /// Get a handle on the custom cell 
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactListViewCell", forIndexPath: indexPath) as! ContactListViewCell

        return cell
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // this is where the magic happens!
        
        /// downcast to ContactListViewCell 
        let contactListCell = cell as? ContactListViewCell
        
        /// Get a handle on the array object i.e. a Person object
        let person = viewModel.fetchContactForItemAtIndexPath(indexPath)
        
        /// Create a a cell view model
        let cellViewModel = ContactListCellViewModel(person: person)
        
        /// Note how we defer the presentation of cell content to a separate function
        contactListCell!.configure(withDataSource: cellViewModel, delegate: cellViewModel)
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

