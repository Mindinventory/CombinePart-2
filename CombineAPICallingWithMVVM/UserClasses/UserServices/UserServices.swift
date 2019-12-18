//
//  UserServices.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 11/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import Foundation
import Combine

class UserService {
    
    static let shared = UserService()
    
    func getUserData() -> AnyPublisher<[UserModel], Error> {
        
        let request = URL(string: "https://jsonplaceholder.typicode.com/users")
        
        return ServiceManager.shared.callAPI(request!)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
