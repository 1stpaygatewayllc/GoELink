//
//  ContactDetailViewController.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 7/30/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import UIKit

/// A controller class for displaying content and handling events (V)
class ContactDetailViewController: UIViewController {

    /// A connection to the Storyboard's Detail label
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    /// This variable is the link between List and Details. Note how this variable was defined within the prepareForSegue function of the ContactListViewModel
    var detailItemViewModel: ContactDetailViewModel? {

        didSet {
            /// Update the view.
            self.configureView()
        }
    }

    /**

        Configure the view content.
        Note that (ContactDetail)ViewModel handles the logic for displaying the content.
    
    */
    func configureView() {
        // Update the user interface for the detail item.
        if let contactDetailViewModel: ContactDetailViewModel = self.detailItemViewModel {
            if let label = self.detailDescriptionLabel {
                label.text = contactDetailViewModel.fullNameText
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

