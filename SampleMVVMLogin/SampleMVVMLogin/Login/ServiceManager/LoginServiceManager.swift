//
//  LoginServiceManager.swift
//  SampleMVVMLogin
//
//  Created by Abhishek Suryawanshi on 09/03/23.
//

import Foundation

typealias loginCompletionHander = Result<User, CustomError>

protocol LoginServiceProtocol {
    func initiateLogin(email: String, password: String, completion: @escaping(loginCompletionHander) -> Void)
}

class LoginServiceManager {
    
    let httpClient: HTTPClient
    
    init(client: HTTPClient = HTTPClient()) {
        self.httpClient = client
    }
    
    func createLoginRequest(with email: String, password: String) -> URLRequest? {
        
        guard let url = URL(string: URLConstant.baseURL + URLConstant.login) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.post.rawValue
        
        do {
            let parameter: [String: Any] = ["email": email, "password": password]
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            return request
        } catch {
            return nil
        }
    }
}

extension LoginServiceManager: LoginServiceProtocol {
    
    func initiateLogin(email: String, password: String, completion: @escaping(loginCompletionHander) -> Void) {
        
        guard let urlRequest = createLoginRequest(with: email, password: password) else {
            completion(.failure(.invalidRequest))
            return
        }
        httpClient.execute(with: urlRequest, completion: completion)
    }
}
