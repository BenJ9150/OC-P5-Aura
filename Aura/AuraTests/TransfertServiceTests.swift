//
//  TransfertServiceTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import XCTest
@testable import Aura

final class TransfertServiceTests: XCTestCase {

    // Note: BadRequest already tested in AuthServiceTests
    // Note: no Data if success, just status 200, so doesn't tested
    
    // MARK: Error response
    
    func testTransfertFailedResponseError() {
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: nil, error: FakeData.error)
        let transfertService = TransfertService(urlSession: urlSession)
        // When
        transfertService.transfert(to: "test", amount: 1000) { result in
            switch result {
            case .success(_):
                XCTFail("error in testTransfertFailedResponseError")
                
            case .failure(let failure):
                // Then
                XCTAssertEqual(failure, AuraError.serverErr)
            }
        }
    }
    
    // MARK: Success
    
    func testTransfertFailedSuccess() {
        // Given
        let urlSession = URLSessionFake(data: Data(), urlResponse: FakeData.statusOK, error: nil)
        let transfertService = TransfertService(urlSession: urlSession)
        // When
        transfertService.transfert(to: "test", amount: 1000) { result in
            switch result {
            case .success(let success):
                // then
                XCTAssertTrue(success)
                
            case .failure(_):
                XCTFail("error in testTransfertFailedSuccess")
            }
        }
    }
}
