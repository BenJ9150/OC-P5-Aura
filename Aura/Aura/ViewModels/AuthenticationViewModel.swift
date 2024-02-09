//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

// OLD
//class AuthenticationViewModel: ObservableObject {
//    @Published var username: String = ""
//    @Published var password: String = ""
//    
//    let onLoginSucceed: (() -> ())
//    
//    init(_ callback: @escaping () -> ()) {
//        self.onLoginSucceed = callback
//    }
//    
//    func login() {
//        print("login with \(username) and \(password)")
//        onLoginSucceed()
//    }
//}

// NEWBEN (tout ce qui est en-dessous) :

class AuthenticationViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var username: String = "" // test@aura.app
    @Published var password: String = "" // test123
    @Published var displayAlert = false
    private(set) var ErrorAlert = AuraError.unknown

    // MARK: - Private properties

    private let onLoginSucceed: (() -> ())

    // MARK: - Init

    init(_ callback: @escaping () -> ()) {
        self.onLoginSucceed = callback
    }

}

// MARK: - Inputs

extension AuthenticationViewModel {

    func login() {
        print("login with \(username) and \(password)")

        // NEWBEN:
        
        // check if is valid mail
        guard username.isValidEmail() else {
            displayError(AuraError.invalidMail)
            return
        }
        
        // signIn
        AuthService().signIn(withEmail: username, andPwd: password) { result in
            switch result {
            case .success(let success):
                if success {
                    self.onLoginSucceed()
                } else {
                    self.displayError(AuraError.keychainErr)
                }
            case .failure(let failure as AuraError):
                self.displayError(failure)
            case .failure(_):
                self.displayError(AuraError.unknown)
            }
        }
    }
}

// MARK: - Private methods

private extension AuthenticationViewModel {

    func displayError(_ failure: AuraError) {
        ErrorAlert = failure
        DispatchQueue.main.async {
            self.displayAlert.toggle()
        }
    }
}


