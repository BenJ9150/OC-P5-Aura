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
    @Published var amount: String = ""
    @Published var transferMessage: String = ""
}

// MARK: - Inputs

extension MoneyTransferViewModel {

    func sendMoney() {
        // Logic to send money - for now, we're just setting a success message.
        // You can later integrate actual logic.
        if !recipient.isEmpty && !amount.isEmpty {
            transferMessage = "Successfully transferred \(amount) to \(recipient)"
        } else {
            transferMessage = "Please enter recipient and amount."
        }
    }
}
