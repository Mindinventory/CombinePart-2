//
//  UserViewModel.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 11/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import Foundation
import Combine

class UserViewModel {
  
    var arrUserData = [UserModel]()
    var userData = CurrentValueSubject<[UserModel], Never>([])
    
    func getUserData() {
        
        let _ = UserService.shared.getUserData()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (_) in
                
            }) { [weak self] (user) in
                
                guard let `self` = self else {
                    return
                }
                
                self.arrUserData = user
                self.userData.send(user)
        }
    }
    
    func getSearchResult(_ str: String) {
        
        let arr = arrUserData.filter({($0.name?.lowercased().contains(str) ?? false)})
        self.userData.send((str.trimmingCharacters(in: .whitespacesAndNewlines) != "") ? arr : arrUserData)
    }
}
