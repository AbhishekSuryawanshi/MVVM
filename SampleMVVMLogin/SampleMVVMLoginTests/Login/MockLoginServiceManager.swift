//
//  MockLoginServiceManager.swift
//  SampleMVVMLoginTests
//
//  Created by Abhishek Suryawanshi on 10/03/23.
//

import Foundation
@testable import SampleMVVMLogin

class MockLoginServiceManager: LoginServiceProtocol {
    let isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func initiateLogin(email: String, password: String, completion: @escaping (loginCompletionHander) -> Void) {
        if isSuccess {
            completion(.success(mockUser()))
        } else {
            completion(.failure(.invalidJson))
        }
    }
    
    private func mockUser() -> User {
        return User(email: "test@test.com",
                    fullName: "fullName",
                    age: 24, bio: "bio234",
                    hobbies: ["test"],
                    metaData: nil)
    }

}
