//
//  UserListTblVCell.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 16/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import UIKit

class UserListTblVCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
