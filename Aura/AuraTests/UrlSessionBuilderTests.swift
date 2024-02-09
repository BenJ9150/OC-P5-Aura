//
//  UrlSessionBuilderTests.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import XCTest
@testable import Aura

final class UrlSessionBuilderTests: XCTestCase {

    // MARK: Data nil
    
    func testBuildUrlSessionFailedDataNil() {
        // set config for url session
        let config = UrlSessionBuilder.UrlSessionConfig(
            httpMethod: .get,
            sUrl: "https://openclassrooms.com",
            parameters: [:],
            withAuth: false
        )
        
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: FakeData.statusOK, error: nil)
        let urlSessionBuilder = UrlSessionBuilder(urlSession: urlSession)
        // When
        urlSessionBuilder.buildUrlSession(config: config) { result in
            switch result {
            case .success(_):
                XCTFail("error in testBuildUrlSessionFailedDataNil")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.invalidData)
                
            case .failure(_):
                XCTFail("error in testBuildUrlSessionFailedDataNil")
            }
        }
    }
    
    // MARK: Bad URL

    func testBuildUrlSessionFailedBadUrl() {
        // set config for url session
        let config = UrlSessionBuilder.UrlSessionConfig(
            httpMethod: .get,
            sUrl: "",
            parameters: [:],
            withAuth: false
        )
        
        // Given
        let urlSession = URLSessionFake(data: nil, urlResponse: nil, error: nil)
        let urlSessionBuilder = UrlSessionBuilder(urlSession: urlSession)
        // When
        urlSessionBuilder.buildUrlSession(config: config) { result in
            switch result {
            case .success(_):
                XCTFail("error in testBuildUrlSessionFailedBadUrl")
                
            case .failure(let failure as AuraError):
                // Then
                XCTAssertEqual(failure, AuraError.invalidUrl)
                
            case .failure(_):
                XCTFail("error in testBuildUrlSessionFailedBadUrl")
            }
        }
    }
}
