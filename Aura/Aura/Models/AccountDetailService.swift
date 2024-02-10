//
//  AccountDetailService.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation

final class AccountDetailService: UrlSessionBuilder {

    func getAccountDetail(_ completion: @escaping (Result<AccountResponse, AuraError>) -> Void) {
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
                    completion(.failure(AuraError.invalidJson))
                    return
                }
                completion(.success(decodedJson))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
