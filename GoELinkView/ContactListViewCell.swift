//
//  ContactsListTableViewCell.swift
//  GoELink
//
//  Created by Ger O'Sullivan on 8/19/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import UIKit



class ContactListViewCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var switchToggle: UISwitch!
    
    private var dataSource: ContactTextCellDataSource?
    private var delegate: ContactTextCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
    Configures the cell content to display

    :param: dataSource The dataSource of the cell (i.e. ContactTextCellDataSource).
    :param: delegate The delegate of the cell.(i.e. ContactTextCellDelegate).
    
    */
    func configure(withDataSource dataSource: ContactTextCellDataSource, delegate: ContactTextCellDelegate?) {
        self.dataSource = dataSource
        self.delegate = delegate
        
        self.textLabel?.text = dataSource.fullName
        // color option added!
        self.textLabel?.textColor = delegate?.textColor
        self.textLabel?.font = delegate?.font
        
    }
    
    

}