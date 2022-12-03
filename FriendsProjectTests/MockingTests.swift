//
//  MockingTests.swift
//  FriendsProjectTests
//
//  Created by LanceMacBookPro on 12/2/22.
//

import XCTest
@testable import FriendsProject

class MockingTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func testLoginResponse() {
        
        let expectation = self.expectation(description: "Log User In")
        
        let email = "123@gmail.com"
        let password = "123456"
        
        Service.shared.logUserInUsingFakeURLSession(email: email, password: password) { (result) in
            switch result {
            
            case .failure(let fakeSessionError):
                
                print("Test-Fake-Server-Response-Login-Error: ", fakeSessionError)
                
                XCTFail()
                
            case .success(_):
            
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testFriendsFetch() {
        
        let expectation = self.expectation(description: "Fetch Friends")
        
        Service.shared.fetchAPIObjectUsingFakeURLSession { (result) in
            switch result {
            
            case .failure(let fakeSessionError):
                
                print("Test-Fake-Server-Response-Fetch-Friends-Error: ", fakeSessionError)
            
                XCTFail()
                
            case .success(let friends):
                
                let jsonResponseFileCount = 5
                
                XCTAssertEqual(friends.count, jsonResponseFileCount)
                
                let jsonResponseFileTestName = "delilah"
                guard let _ = friends.firstIndex(where: { $0.name == jsonResponseFileTestName }) else {
                    XCTFail()
                    return
                }
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testFriendCellViewModel() {
        
        let friend = Friend(name: "jill", email: "jill@gmail.com")
        let friendCellViewModel = FriendCellViewModel(name: friend.name, email: friend.email)
        
        let testName = "Jill"
        let testEmail = "jill@gmail.com"
        
        friendCellViewModel.nameTxt = { (name) in
            XCTAssertEqual(name, testName)
        }
        
        friendCellViewModel.emailTxt = { (email) in
            XCTAssertEqual(email, testEmail)
        }
        
        friendCellViewModel.setNameTxtAndEmailTxt()
    }
    
    func testPerformanceExample() throws {
        try super.tearDownWithError()
    }
}
