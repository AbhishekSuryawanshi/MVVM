//
//  LoginViewModelTests.swift
//  SampleMVVMLoginTests
//
//  Created by Abhishek Suryawanshi on 10/03/23.
//

import XCTest
@testable import SampleMVVMLogin

final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    override func setUpWithError() throws {
        
    }
    
    func testAuthenticateUserInformationValidParams() {
        viewModel = LoginViewModel(service: MockLoginServiceManager(isSuccess: true))
        let expectation = XCTestExpectation(description: "testing authenticate service")
        
        viewModel.userClosure = { user in
            XCTAssertEqual(user.email, "test@test.com")
            expectation.fulfill()
        }
        
        viewModel.authenticateUserInformation(email: "test", password: "test")
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    
    func testAuthenticateUserInformationInValidParams() {
        viewModel = LoginViewModel(service: MockLoginServiceManager(isSuccess: false))
        let expectation = XCTestExpectation(description: "testing authenticate service")
        
        viewModel.showError = { error in
            XCTAssertEqual(error.description, "Something went wrong, please try again")
            expectation.fulfill()
        }
        
        viewModel.authenticateUserInformation(email: "test", password: "test")
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
