//
//  ApiError.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 26/01/2024.
//

import Foundation

enum ApiError: Error {
    case serverErr
    case invalidUrl
    case badStatusCode
    case invalidData
    case invalidJson
    case keychainErr
    case decimalCast
    case unknown

    // MARK: Message Builder

    /// Call example: let ErrorMess = ApiError.invalidUrl.message
    var message: String {
        let start = "Please restart the application"
        
        switch self {
        case .serverErr:
            return "\(start)\nError: 101, launch server...!"
        case .invalidUrl:
            return "\(start)\nError: 102"
        case .badStatusCode:
            return "\(start)\nError: 103"
        case .invalidData:
            return "\(start)\nError: 104"
        case .invalidJson:
            return "\(start)\nError: 105"
        case .keychainErr:
            return "\(start)\nError: 106"
        case .decimalCast:
            return "The amount entered does not appear to be a number."
        case .unknown:
            return "\(start)\nError: 100"
        }
    }

    var title: String {
        return "sorry, a problem occurred!"
    }
}
