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

    @Published var username: String = "test@aura.app"
    @Published var password: String = "test123"
    @Published var displayErrorAlert = false
    private(set) var ErrorAlert = ApiError.unknown

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

        // NEWBEN: signIn method
        AuthService().signIn(withEmail: username, andPwd: password) { result in
            switch result {
            case .success(let success):
                if success {
                    self.onLoginSucceed()
                } else {
                    self.displayError(ApiError.keychainErr)
                }
            case .failure(let failure as ApiError):
                self.displayError(failure)
            case .failure(_):
                self.displayError(ApiError.unknown)
            }
        }
    }
}

// MARK: - Private methods

private extension AuthenticationViewModel {

    func displayError(_ failure: ApiError) {
        ErrorAlert = failure
        DispatchQueue.main.async {
            self.displayErrorAlert.toggle()
        }
    }
}
