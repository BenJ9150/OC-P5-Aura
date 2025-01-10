//
//  TransfertService.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import Foundation

final class TransfertService: UrlSessionBuilder {
    
    func transfert(to recipient: String, amount: Decimal, _ completion: @escaping (Result<Bool, AuraError>) -> Void) {
        // set config for url session
        let config = UrlSessionConfig(
            httpMethod: .post,
            sUrl: EndPoint.transfer.url,
            parameters: [BodyKey.recipient: recipient, BodyKey.amount: amount],
            withAuth: true
        )
        // get data
        buildUrlSession(config: config) { result in
            switch result {
            case .success:
                // data is empty, no need to decode
                completion(.success(true))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
