//
//  Endpoint.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation

enum EndPoint {

    case domain
    case auth
    case account
    case transfer

    // MARK: URL Builder

    /// Call example:
    /// let url = EndPoint.auth.url
    var url: String {
        let domain = "http://127.0.0.1:8080"
        
        switch self {
        case .domain:
            return domain
        case .auth:
            return "\(domain)/auth"
        case .account:
            return "\(domain)/account"
        case .transfer:
            return "\(domain)/account/transfer"
        }
    }
}

final class BodyKey {

    // http body
    static let username = "username"
    static let password = "password"
    static let recipient = "recipient"
    static let amount = "amount"

    // body response
    static let token = "token"
    static let currentBalance = "currentBalance"
    static let value = "value"
    static let label = "label"
}
