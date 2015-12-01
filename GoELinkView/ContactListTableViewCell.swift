//
//  ContactListTableViewCell.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 9/4/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//
import CommonUtils
import GoELinkViewModel
import ReactiveCocoa

internal final class ContactListTableViewCell: UITableViewCell {
    internal var viewModel: ContactListTableViewCellModeling? {
        didSet {
            let firstName:String = (viewModel?.first_name)!
            let lastName:String = (viewModel?.last_name)!
            fullNameLabel.text = "\(firstName) \(lastName)"
//            imageSizeLabel.text = viewModel?.pageImageSizeText
            
            if let viewModel = viewModel {
                viewModel.getProfileImage()
                    .takeUntil(self.racutil_prepareForReuseProducer)
                    .on(next: { self.profileImageView.image = $0 })
                    .start()
            }
            else {
                profileImageView.image = nil
            }
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
//    @IBOutlet weak var imageSizeLabel: UILabel!
}

