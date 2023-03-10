//
//  LoginViewModel.swift
//  SampleMVVMLogin
//
//  Created by Abhishek Suryawanshi on 09/03/23.
//

import Foundation

class LoginViewModel {
    
    var showError: ((String) -> ())?
    var displayLoader: ((Bool) -> ())?
    var userClosure: ((User) -> ())?
    
    let service: LoginServiceProtocol
    
    init(service: LoginServiceProtocol = LoginServiceManager()) {
        self.service = service
    }
    
    func authenticateUserInformation(email: String, password: String) {
        displayLoader?(true)
        
        service.initiateLogin(email: email, password: password) { [weak self] result in
            self?.displayLoader?(false)
            switch result {
            case .failure(let error):
                
                self?.showError?(error.description)
            case .success(let model):
                self?.userClosure?(model)
            }
        }
    }
    
    func validate(email: String?, password: String?) -> String? {
        guard let email = email, email.isValidEmail else {
            return "Invalid email"
        }
        guard let password = password, password.isStrongPassword else {
            return "Invalid password"
        }
        return nil
    }
}
