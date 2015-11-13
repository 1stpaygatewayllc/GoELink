//
//  ContactListClient.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/3/15.
//  Copyright (c) 2015 GoEmerchant. All rights reserved.
//

import Foundation

typealias ContactViewModelCompletionHandler = (contacts:[Person]?, errorMsg: String?) -> Void

/// A class for managing communication with the data/network layer.
public class ContactListClient: NSObject {
    
    /**
        Fetches a list of Contacts from service
    
        :param: contactService The service to use to retrieve contacts.
        :param: completion An array of person objects
    
    */
    
    func fetchContacts(contactService: ContactNetworkedStorageService, completion: ContactViewModelCompletionHandler) throws {
        
        do {
            // fetch the data
            contactService.fetchAll { contactDataResult in
                switch (contactDataResult) {
                case .Success(let contactData):
                    completion(contacts:contactData, errorMsg: nil)
                    
                case .Failure(let error):
                    completion(contacts:nil, errorMsg: "FAILURE: \(error)" )
                }
                
            }
        } 
        
    }
}
