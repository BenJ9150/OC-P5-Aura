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

    @Published var recipient: String = ""
    @Published var amount: String =  ""
    @Published var transferMessage: String = ""
}

// MARK: - Inputs

extension MoneyTransferViewModel {

    func sendMoney() {
        
        // check if data empty
        guard !recipient.isEmpty, !amount.isEmpty else {
            transferMessage = "Please enter recipient and amount."
            return
        }
        
        // check valid mail or phone
        guard (recipient.isValidEmail() || recipient.isValidPhone()) else {
            transferMessage = "Please enter a valid recipient."
            return
        }
        
        // check valid amount
        guard let decimalAmount = Decimal(string: amount) else {
            transferMessage = "Please enter a valid amount."
            return
        }
        
        // transfert
        TransfertService().transfert(to: recipient, amount: decimalAmount) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.transferMessage = "Successfully transferred \(self.amount)€ to \(self.recipient)"
                case .failure(let failure as AuraError):
                    self.transferMessage = failure.title + "\n" + failure.message
                case .failure(_):
                    self.transferMessage = AuraError.unknown.title
                }
            }
        }
    }
}
