//
//  AuthService.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation

final class AuthService: UrlSessionBuilder {
    
    func signIn(withEmail mail: String, andPwd password: String, _ completion: @escaping (Result<Bool, AuraError>) -> Void) {
        // set config for url session
        let config = UrlSessionConfig(
            httpMethod: .post,
            sUrl: EndPoint.auth.url,
            parameters: [BodyKey.username: mail, BodyKey.password: password],
            withAuth: false
        )
        
        // get data
        buildUrlSession(config: config) { result in
            switch result {
            case .success(let data):
                // decode json
                guard let decodedJson = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
                    completion(.failure(AuraError.invalidJson))
                    return
                }
                // Save token
                KeychainManager.token = decodedJson.token
                completion(.success(true))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
