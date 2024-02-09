//
//  AccountDetailServiceTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import XCTest
@testable import Aura

final class AccountDetailServiceTests: XCTestCase {

    // Note: BadRequest already tested in AuthServiceTests
    
    // MARK: Error response
    
    func testGetAccountDetailFailedResponseError() {
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: nil, error: FakeData.error)
        let accountDetailService = AccountDetailService(urlSession: urlSession)
        // When
        accountDetailService.getAccountDetail { result in
            switch result {
            case .success(_):
                XCTFail("error in testGetAccountDetailFailedResponseError")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.serverErr)
                
            case .failure(_):
                XCTFail("error in testGetAccountDetailFailedResponseError")
            }
        }
    }
    
    // MARK: Bad data
    
    func testGetAccountDetailFailedBadData() {
        // Given
        let urlSession = URLSessionFake(data: FakeData.incorrectData, urlResponse: FakeData.statusOK, error: nil)
        let accountDetailService = AccountDetailService(urlSession: urlSession)
        // When
        accountDetailService.getAccountDetail { result in
            switch result {
            case .success(_):
                XCTFail("error in testGetAccountDetailFailedBadData")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.invalidJson)
                
            case .failure(_):
                XCTFail("error in testGetAccountDetailFailedBadData")
            }
        }
    }
    
    // MARK: Success
    
    func testGetAccountDetailSuccess() {
        // Given
        let urlSession = URLSessionFake(data: FakeData.accountDetailCorrectData, urlResponse: FakeData.statusOK, error: nil)
        let accountDetailService = AccountDetailService(urlSession: urlSession)
        // When
        accountDetailService.getAccountDetail { result in
            switch result {
            case .success(let transactions):
                // Then
                XCTAssertEqual(transactions.totalAmount, FakeData.currentBalance)
                XCTAssertEqual(transactions.transactions.count, FakeData.transactionsCount)
                XCTAssertEqual(transactions.transactions.first?.description, FakeData.firstTransactionLabel)
                XCTAssertEqual(transactions.transactions.first?.amount, FakeData.firstTransactionValue)
                XCTAssertEqual(transactions.transactions[2].amount, FakeData.thirdTransactionValue)
                
            case .failure(_):
                XCTFail("error in testGetAccountDetailSuccess")
            }
        }
    }
}
