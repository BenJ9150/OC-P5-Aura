//
//  FakeResponseData.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import Foundation

final class FakeData {
    
    // MARK: Global
    
    static let statusOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:]
    )!
    
    static let badRequest = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 400, httpVersion: nil, headerFields: [:]
    )!
    
    
    // MARK: API Error
    
    // Create class with Error protocol to have instance of Error
    class APIError: Error {}
    static let error = APIError()
    
    // MARK: Incorrect Data
    
    static let incorrectData = "erreur".data(using: .utf8)!
    
    // MARK: Correct Data
    
    static let authCorrectToken = "EA68E40B-2AE4-40D4-8E86-D8327F4979AA"
    
    static var authCorrectData: Data {
        return getData(ofFile: "Authentification")
    }
    
    static var accountDetailCorrectData: Data {
        return getData(ofFile: "AccountDetail")
    }
    
    static let currentBalance = "€5,459.32"
    static let transactionsCount = 50
    static let firstTransactionLabel = "IKEA"
    static let firstTransactionValue = "-€56.40"
    static let thirdTransactionValue = "+€1,400.00"
}

private extension FakeData {

    static func getData(ofFile file: String) -> Data {
        // get bundle for json localization
        let bundle = Bundle(for: FakeData.self)
        // get url
        let url = bundle.url(forResource: file, withExtension: "json")
        // get data
        let data = try! Data(contentsOf: url!)
        return data
    }
}
