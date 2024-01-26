//
//  AccountService.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation

final class AccountService: UrlSessionBuilder {

    // MARK: Singleton

    static let shared = AccountService()
}

// MARK: Public methods

extension AccountService {
    
    func getAccount(_ completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        // set config for url session
        let config = UrlSessionConfig(
            httpMethod: .get,
            sUrl: EndPoint.account.url,
            parameters: nil,
            withAuth: true
        )
        // get data
        buildUrlSession(config: config) { result in
            switch result {
            case .success(let data):
                // decode json
                guard let decodedJson = try? JSONDecoder().decode(AccountResponse.self, from: data) else {
                    completion(.failure(ApiError.invalidJson))
                    return
                }
                completion(.success(decodedJson))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func transfert(to recipient: String, amount: String, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        // convert amount to decimal
        guard let decimalAmount = Decimal(string: amount) else {
            completion(.failure(ApiError.decimalCast))
            return
        }
        // set config for url session
        let config = UrlSessionConfig(
            httpMethod: .post,
            sUrl: EndPoint.transfer.url,
            parameters: [BodyKey.recipient: recipient, BodyKey.amount: decimalAmount],
            withAuth: true
        )
        // get data
        buildUrlSession(config: config) { result in
            switch result {
            case .success(let data):
                // data is empty, no need to decode
                completion(.success(true))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
