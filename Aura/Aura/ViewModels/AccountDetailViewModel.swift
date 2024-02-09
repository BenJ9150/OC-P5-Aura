//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

// OLD:
//class AccountDetailViewModel: ObservableObject {
//
//    @Published var totalAmount: String = "€12,345.67"
//    @Published var recentTransactions: [Transaction] = [
//        Transaction(description: "Starbucks", amount: "-€5.50"),
//        Transaction(description: "Amazon Purchase", amount: "-€34.99"),
//        Transaction(description: "Salary", amount: "+€2,500.00")
//    ]
//    
//    struct Transaction {
//        let description: String
//        let amount: String
//    }
//}

// NEWBEN (tout ce qui est en-dessous) :

class AccountDetailViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var totalAmount: String = ""
    @Published var recentTransactions: [Transaction] = []
    @Published var displayAlert = false
    @Published var showAlltransactions = false
    private(set) var allTransactions: [Transaction] = []
    private(set) var ErrorAlert = AuraError.unknown

    // MARK: - Private properties

    private let onSignOut: (() -> ())

    // MARK: - Init

    init(_ callback: @escaping () -> ()) {
        self.onSignOut = callback
        self.loadTransactions()
    }
}

// MARK: - Inputs

extension AccountDetailViewModel {

    func signOut() {
        KeychainManager.deleteTokenInKeychain()
        self.onSignOut()
    }

    func loadTransactions() {
        AccountService.shared.getAccount { result in
            switch result {
            case .success(let success):
                self.publishAccount(success)
            case .failure(let failure as AuraError):
                self.displayError(failure)
            case .failure(_):
                self.displayError(AuraError.unknown)
            }
        }
    }
}

// MARK: - Private methods

private extension AccountDetailViewModel {

    func publishAccount(_ account: AccountResponse) {
        allTransactions = account.transactions
        DispatchQueue.main.async {
            self.totalAmount = account.totalAmount
            self.recentTransactions = Array(account.transactions.prefix(3))
        }
    }

    func displayError(_ failure: AuraError) {
        ErrorAlert = failure
        DispatchQueue.main.async {
            self.displayAlert.toggle()
        }
    }
}
