//
//  KeychainManagerTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 10/02/2024.
//

import XCTest
@testable import Aura

final class KeychainManagerTests: XCTestCase {

    override class func tearDown() {
        // delete token for new test
        KeychainManager.deleteTokenInKeychain()
        print("token deleted for test")
        print(KeychainManager.token)
    }

    // MARK: Update token

    func testUpdateTokenSuccess() {
        // Given
        KeychainManager.token = "TokenToUpdate"
        // When
        KeychainManager.token = FakeData.authCorrectToken
        // Then
        XCTAssertEqual(KeychainManager.token, FakeData.authCorrectToken)
    }

    // MARK: Delete token
    
    func testDeleteTokenSuccess() {
        // Given
        KeychainManager.token = FakeData.authCorrectToken
        // When
        KeychainManager.deleteTokenInKeychain()
        // Then
        XCTAssertEqual(KeychainManager.token, "")
    }
}
