//
//  ContactListTableViewController.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/4/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import GoELinkViewModel

public final class ContactListTableViewController: UITableViewController {
    private var autoSearchStarted = false
//    @IBOutlet var footerView: UIView!
//    @IBOutlet weak var searchingIndicator: UIActivityIndicatorView!
    
    public var viewModel: ContactListTableViewModeling? {
        didSet {
            if let viewModel = viewModel {
                viewModel.cellModels.producer
                    .on(next: { _ in self.tableView.reloadData() })
                    .start()
                viewModel.searching.producer
                    .on(next: { searching in
                        if searching {
                            // Display the activity indicator at the center of the screen if the table is empty.
//                            self.footerView.frame.size.height = viewModel.cellModels.value.isEmpty
//                                ? self.tableView.frame.size.height + self.tableView.contentOffset.y : 44.0
                            
//                            self.tableView.tableFooterView = self.footerView
//                            self.searchingIndicator.startAnimating()
                        }
                        else {
//                            self.tableView.tableFooterView = nil
//                            self.searchingIndicator.stopAnimating()
                        }
                    })
                    .start()
                viewModel.errorMessage.producer
                    .on(next: { errorMessage in
                        if let errorMessage = errorMessage {
                            self.displayErrorMessage(errorMessage)
                        }
                    })
                    .start()
            }
        }
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !autoSearchStarted {
            autoSearchStarted = true
            viewModel?.startSearch()
        }
        
//        if (viewModel!.refreshing.value == true) {
//            self.tableView.reloadData()
//        }
    }
    
    private func displayErrorMessage(errorMessage: String) {
        let title = LocalizedString("ContactListTableViewController_ErrorAlertTitle", comment: "Error alert title.")
        let dismissButtonText = LocalizedString("ContactListTableViewController_DismissButtonTitle", comment: "Dismiss button title on an alert.")
        let message = errorMessage
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: dismissButtonText, style: .Default) { _ in
            alert.dismissViewControllerAnimated(true, completion: nil)
            })
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension ContactListTableViewController {
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.cellModels.value.count
        }
        return 0
        
        // The following code invokes didSet of viewModel property. A bug?
        // return viewModel?.cellModels.value.count ?? 0
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactListTableViewCell", forIndexPath: indexPath) as! ContactListTableViewCell
        cell.viewModel = viewModel.map { $0.cellModels.value[indexPath.row] }
        
//        print("Name: \(cell.viewModel!.first_name) \(cell.viewModel!.last_name) - ObjectId: \(cell.viewModel!.objectId)")
        
            
//        if let viewModel = viewModel
//            where indexPath.row >= viewModel.cellModels.value.count - 1 && viewModel.loadNextPage.enabled.value {
//                viewModel.loadNextPage.apply(()).start()
//        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactListTableViewController {
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel?.selectCellAtIndex(indexPath.row)
        performSegueWithIdentifier("ContactDetailViewControllerSegue", sender: self)
    }
}

