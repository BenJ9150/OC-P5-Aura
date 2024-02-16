//
//  URLSessionDataTaskFake.swift
//  AuraTests
//
//  Created by Benjamin LEFRANCOIS on 16/02/2024.
//

import Foundation

class URLSessionDataTaskFake: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
}
