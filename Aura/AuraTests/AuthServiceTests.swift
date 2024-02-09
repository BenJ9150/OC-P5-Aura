//
//  AuthServiceTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import XCTest
@testable import Aura

final class AuthServiceTests: XCTestCase {
    
    // MARK: Bad request
    
    func testSignInFailedBadRequest() {
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: FakeData.badRequest, error: nil)
        let authService = AuthService(urlSession: urlSession)
        // When
        authService.signIn(withEmail: "test", andPwd: "test") { result in
            switch result {
            case .success(_):
                XCTFail("error in testSignInFailedBadRequest")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.badStatusCode)
                
            case .failure(_):
                XCTFail("error in testSignInFailedBadRequest")
            }
        }
    }
    
    // MARK: Error response
    
    func testSignInFailedErrorResponse() {
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: nil, error: FakeData.error)
        let authService = AuthService(urlSession: urlSession)
        // When
        authService.signIn(withEmail: "test", andPwd: "test") { result in
            switch result {
            case .success(_):
                XCTFail("error in testSignInFailedErrorResponse")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.serverErr)
                
            case .failure(_):
                XCTFail("error in testSignInFailedErrorResponse")
            }
        }
    }
    
    // MARK: Bad data
    
    func testSignInFailedBadData() {
        // Given
        let urlSession = URLSessionFake(data: FakeData.incorrectData, urlResponse: FakeData.statusOK, error: nil)
        let authService = AuthService(urlSession: urlSession)
        // When
        authService.signIn(withEmail: "test", andPwd: "test") { result in
            switch result {
            case .success(_):
                XCTFail("error in testSignInFailedBadData")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.invalidJson)
                
            case .failure(_):
                XCTFail("error in testSignInFailedBadData")
            }
        }
    }
    
    // MARK: Success
    
    func testSignInSuccess() {
        // Given
        let urlSession = URLSessionFake(data: FakeData.authCorrectData, urlResponse: FakeData.statusOK, error: nil)
        let auth = AuthService(urlSession: urlSession)
        // When
        auth.signIn(withEmail: "test", andPwd: "test") { result in
            switch result {
            case .success(let success):
                // then
                XCTAssertTrue(success)
                XCTAssertEqual(KeychainManager.token, FakeData.authCorrectToken)
                
            case .failure(_):
                XCTFail("error in testSignInSuccess")
            }
        }
    }
    
    override class func tearDown() {
        // delete token for new test
        KeychainManager.deleteTokenInKeychain()
        print("token deleted for test")
        print(KeychainManager.token)
    }
}
