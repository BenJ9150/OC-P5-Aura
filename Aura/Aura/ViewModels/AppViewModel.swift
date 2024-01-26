//
//  AppViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AppViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var isLogged: Bool
    
    var authenticationViewModel: AuthenticationViewModel {
        return AuthenticationViewModel { [weak self] in
            DispatchQueue.main.async {
                self?.isLogged = true
            }
        }
    }
    
    var accountDetailViewModel: AccountDetailViewModel {
        return AccountDetailViewModel { [weak self] in  // NEWBEN: add closure to signOut
            DispatchQueue.main.async {
                self?.isLogged = false
            }
        }
    }

    // MARK: - Init

    init() {
        isLogged = KeychainManager.userIsLogged // NEWBEN, old: isLogged = false
    }
}
