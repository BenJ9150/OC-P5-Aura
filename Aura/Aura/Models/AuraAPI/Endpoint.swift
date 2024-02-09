//
//  Endpoint.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation

enum EndPoint {

    case auth
    case account
    case transfer

    // MARK: URL Builder

    /// Call example: let url = EndPoint.auth.url
    var url: String {
        let domain = "http://127.0.0.1:8080"
        
        switch self {
        case .auth:
            return "\(domain)/auth"
        case .account:
            return "\(domain)/account"
        case .transfer:
            return "\(domain)/account/transfer"
        }
    }
}
