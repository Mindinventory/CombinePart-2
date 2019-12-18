//
//  UserListVC.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 16/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import UIKit
import Combine

class UserListVC: UIViewController {
    
    fileprivate enum Section: CaseIterable {
        case main
    }
    
    @IBOutlet fileprivate weak var tblVUserList: UITableView!
    @IBOutlet fileprivate weak var txtSearch: UITextField!
    
    fileprivate var dataSource: UITableViewDiffableDataSource<Section, UserModel>!

    private var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
}

// MARK:- Initialization -
extension UserListVC {
    
    fileprivate func initialization() {
        
        self.title = "User List"
        self.setupSearchField()
        
        tblVUserList.register(UINib(nibName: "UserListTblVCell", bundle: nil), forCellReuseIdentifier: "UserListTblVCell")
        self.tblVUserList.delegate = self
        self.setupDatasource()
        userViewModel.getUserData()
        
        let _ = userViewModel.userData
            .receive(on: RunLoop.main)
            .sink { [weak self] (user) in
                
                guard let `self` = self else {
                    return
                }
                
                self.createSnapshot(user)
        }
    }
    
    fileprivate func setupSearchField() {
        
        DispatchQueue.main.async { [weak self] in
                       
            guard let `self` = self else {
                return
            }
            
            self.txtSearch.layer.cornerRadius = 5
            self.txtSearch.setLeftPaddingPoints(10)
            self.txtSearch.setRightPaddingPoints(10)
            self.txtSearch.layer.borderColor = UIColor.black.cgColor
            self.txtSearch.layer.borderWidth = 1
        }
    }
}

// MARK:- Diffable DataSource Setup & UITableView Delegate methods -
extension UserListVC: UITableViewDelegate {
    
    fileprivate func setupDatasource() {
        
        dataSource = UITableViewDiffableDataSource<Section, UserModel>(tableView: tblVUserList, cellProvider: { [weak self] (UITableView, indexPath, user) -> UITableViewCell? in
            
            guard let `self` = self else {
                return UITableViewCell()
            }
            
            if let cell = self.tblVUserList.dequeueReusableCell(withIdentifier: "UserListTblVCell", for: indexPath) as? UserListTblVCell {
                
                cell.lblUserName.text = user.name
                cell.lblUserEmail.text = user.email
                
                return cell
            }
            
            return UITableViewCell()
        })
    }
    
    fileprivate func createSnapshot(_ users: [UserModel]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        if let userDetailVC = self.storyboard?.instantiateViewController(identifier: "UserDetailVC") as? UserDetailVC {
            userDetailVC.userData = user
            self.navigationController?.pushViewController(userDetailVC, animated: true)
        }
    }
}

// MARK:- Action events -
extension UserListVC {
    
    @IBAction fileprivate func txtSearchUpdate(_ sender: UITextField) {
        
        userViewModel.getSearchResult(sender.text ?? "")
    }
}
