//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var viewModel: AccountDetailViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Large Header displaying total amount
                accountDetailHeader
                // Display recent transactions
                recentTransactions
                // Button to see details of transactions
                showTransactionDetailsBtn
                Spacer()
            }
            .toolbar {
                exitToolbarItem {
                    viewModel.signOut()
                }
            }
            .alert(viewModel.ErrorAlert.title, isPresented: $viewModel.displayAlert) {  // NEWBEN: error alert
                Button(role: .cancel) {} label: {
                    Text("OK")
                }
            } message: {
                Text(viewModel.ErrorAlert.message)
            }
        }
        .sheet(isPresented: $viewModel.showAlltransactions) {
            AllTransactionsView(allTransactions: viewModel.allTransactions)
        }
    }
}

private extension AccountDetailView {

    var accountDetailHeader: some View {
        VStack(spacing: 10) {
            Text("Your Balance")
                .font(.headline)
            Text(viewModel.totalAmount)
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(Color(hex: "#94A684")) // Using the green color you provided
            Image(systemName: "eurosign.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .foregroundColor(Color(hex: "#94A684"))
        }
        .padding(.top)
    }

    var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Transactions")
                .font(.headline)
                .padding([.horizontal])
            ForEach(viewModel.recentTransactions, id: \.description) { transaction in
                TransactionRowView(transaction: transaction)
            }
        }
    }

    var showTransactionDetailsBtn: some View {
        Button(action: {
            viewModel.showAlltransactions.toggle()
        }) {
            HStack {
                Image(systemName: "list.bullet")
                Text("See Transaction Details")
            }
            .padding()
            .background(Color(hex: "#94A684"))
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    AccountDetailView(viewModel: AccountDetailViewModel({
        
    }))
}
