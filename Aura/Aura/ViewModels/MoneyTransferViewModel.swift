//
//  MoneyTransferViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

// OLD:
//class MoneyTransferViewModel: ObservableObject {
//    @Published var recipient: String = ""
//    @Published var amount: String = ""
//    @Published var transferMessage: String = ""
//    
//    func sendMoney() {
//        // Logic to send money - for now, we're just setting a success message.
//        // You can later integrate actual logic.
//        if !recipient.isEmpty && !amount.isEmpty {
//            transferMessage = "Successfully transferred \(amount) to \(recipient)"
//        } else {
//            transferMessage = "Please enter recipient and amount."
//        }
//    }
//}

// NEWBEN (tout ce qui est en-dessous) :

class MoneyTransferViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var recipient: String = "+33 6 01 02 03 04"
    @Published var amount: String = "12.4"
    @Published var transferMessage: String = ""
    @Published var displayAlert = false
    private(set) var AlertInfo: (title: String, mess: String) = ("", "")
}

// MARK: - Inputs

extension MoneyTransferViewModel {

    func sendMoney() {
        AccountService.shared.transfert(to: recipient, amount: amount) { result in
            switch result {
            case .success(_):
                self.displaySuccess()
            case .failure(let failure as ApiError):
                self.displayError(failure)
            case .failure(_):
                self.displayError(ApiError.unknown)
            }
        }
    }
}

// MARK: - Private methods

private extension MoneyTransferViewModel {

    func displaySuccess() {
        AlertInfo.title = "Transfer done successfully!"
        AlertInfo.mess = ""
        DispatchQueue.main.async {
            self.displayAlert.toggle()
        }
    }

    func displayError(_ failure: ApiError) {
        AlertInfo.title = failure.title
        AlertInfo.mess = failure.message
        DispatchQueue.main.async {
            self.displayAlert.toggle()
        }
    }
}
