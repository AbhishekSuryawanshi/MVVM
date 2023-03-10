//
//  LoginViewController.swift
//  SampleMVVMLogin
//
//  Created by Abhishek Suryawanshi on 09/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: LoginViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = LoginViewModel()
        viewModel?.showError = { [weak self] message in
            self?.showAlert(title: StringConstant.alert, message: message)
        }
        
        viewModel?.displayLoader = { [weak self] value in
            DispatchQueue.main.async {
                self?.showActivityIndicator(value: value)
            }
        }
        
        viewModel?.userClosure = { [weak self] user in
            self?.navigateToUserDetails(user)
        }
    }
    
    func showActivityIndicator(value: Bool) {
        loader.isHidden = !value
        value ? loader.startAnimating() : loader.stopAnimating()
    }
    
    @IBAction func userLoginButton(_ sender: Any) {
        guard Reachability.isConnectedToNetwork() else {
            showAlert(title: StringConstant.alert, message: StringConstant.networkAlert)
            return
        }
        
        guard let email = userEmailTextField.text, let password = userPasswordTextField.text else {
            showAlert(title: StringConstant.alert, message: StringConstant.invalidInput)
            return
        }
        
        if let validationMessage = viewModel?.validate(email: email, password: password) {
            showAlert(title: StringConstant.alert, message: validationMessage)
        } else {
            viewModel?.authenticateUserInformation(email: email, password: password)
        }
    }
    
    private func navigateToUserDetails(_ user: User) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
            self.present(viewController, animated: true)
        }
    }
}

