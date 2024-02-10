//
//  AuraErrorMessageTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 10/02/2024.
//

import XCTest
@testable import Aura

final class AuraErrorMessageTests: XCTestCase {

    func testAuraErrorMessage() {
        XCTAssertEqual(AuraError.serverErr.message, "Please restart the application\nError: 101, launch server")
        XCTAssertEqual(AuraError.invalidUrl.message, "Please restart the application\nError: 102")
        XCTAssertEqual(AuraError.badStatusCode.message, "Please restart the application\nError: 103")
        XCTAssertEqual(AuraError.invalidData.message, "Please restart the application\nError: 104")
        XCTAssertEqual(AuraError.invalidJson.message, "Please restart the application\nError: 105")
        XCTAssertEqual(AuraError.invalidMail.message, "Email is invalid! Change your email and try again.")
        XCTAssertEqual(AuraError.unknown.message, "Please restart the application\nError: 100")
    }
}
