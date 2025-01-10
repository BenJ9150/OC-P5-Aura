//
//  AllTransactionsView.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 26/01/2024.
//

import SwiftUI

struct AllTransactionsView: View {
    @Environment(\.dismiss) var dismiss

    let allTransactions: [Transaction]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ForEach(allTransactions, id: \.description) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            }
            .navigationTitle("Transaction Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                exitToolbarItem {
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    AllTransactionsView()
//}


