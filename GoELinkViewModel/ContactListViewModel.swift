//
//  PersonViewModel.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/3/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import Foundation
import GoELinkModel

typealias ContactViewControllerCompletionHandler = (success:Bool?, errorMsg: String?) -> Void

/// A view model (VM) class for managing the logic of Contact List Table View Controller/View (V)
class ContactListViewModel: NSObject {
    
    /// an array of Person objects
    var contacts: [Person]?
    

    /// an object connector linked to the storyboard
    @IBOutlet var contactsListClient: ContactListClient!
    
    
    /**
        Fetches a list of Contacts
        
        :param: contactService The service to use to retrieve contacts. Default set to ContactLocalStorageService()
        :param: completion Closure returning a success (Bool) and errorMsg (String)
    
    */
    func fetchContacts(completion: ContactViewControllerCompletionHandler) {
        
        do {
            let contactService: ContactNetworkedStorageService = ContactNetworkedStorageService()
            try contactsListClient.fetchContacts(contactService, completion:{(contacts:[Person]?, errorMsg:String?) in
                
                if contacts?.count as Int? > 0 {
                    self.contacts = contacts
                    completion(success: true, errorMsg: nil)
                } else {
                    completion(success: false, errorMsg: "Failed to load content")
                }
            })
        } catch {
            print("error on fetch")
        }

    }
    


    
    /**
        Calculates the number of items in a table section
    
        :param: section The section number
    
    */
    func numberOfItemsInSection(section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    /**
        Computes the full name value for each person based upon display format prefs
    
    
        :param: indexPath The position of the entry in the table view.
    
    */
    func fullNameTextForItemAtIndexPath(indexPath: NSIndexPath) -> String {

        if let person: Person = contacts?[indexPath.row] as Person! {
            return PersonUtils.firstNameSurNameDisplay(person)
//            return PersonUtils.surNameFirstNameDisplay(person)
        } else {
            return ""
        }
        
    }
    
    /**
        Fetches the contact for a specific entry in the table view.
    
    
        :param: indexPath The position of the entry in the table view.
    
    */
    func fetchContactForItemAtIndexPath(indexPath: NSIndexPath) -> Person {
        return (contacts?[indexPath.row] ?? nil)!
    }
       
    
    
}