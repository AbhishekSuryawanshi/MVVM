//
//  User.swift
//  SampleMVVMLogin
//
//  Created by Abhishek Suryawanshi on 09/03/23.
//

import Foundation

struct User: Decodable {
    let email: String
    let fullName: String
    let age: Int
    let bio: String
    let hobbies: [String]?
    let metaData: MetaData?
}

struct MetaData: Decodable {
    
}

struct BackEndError: Decodable {
    let errorMessage: String
    let erroCode: String
}
