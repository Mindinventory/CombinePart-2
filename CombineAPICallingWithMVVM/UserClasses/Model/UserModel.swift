//
//  UserModel.swift
//  CombineAPICallingWithMVVM
//
//  Created by mac-00015 on 11/12/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import Foundation

struct UserModel: Decodable, Hashable {
    
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}

struct Address: Decodable, Hashable {
    
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Decodable, Hashable {
    
    let lat: String?
    let lng: String?
}

struct Company: Decodable, Hashable {
    
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
