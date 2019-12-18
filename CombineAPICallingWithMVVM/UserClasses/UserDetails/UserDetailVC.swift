//
//  UserDetailVC.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 17/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserNumber: UILabel!
    
    var userData: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
}

// MARK:- Initialization -
extension UserDetailVC {
    
    fileprivate func initialization() {
        
        lblUserName.text = userData?.name
        lblUserEmail.text = userData?.email
        lblUserNumber.text = userData?.phone
    }
}
