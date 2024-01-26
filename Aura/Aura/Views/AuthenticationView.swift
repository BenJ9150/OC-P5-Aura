//
//  AuthenticationView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AuthenticationView: View {
    
//    @State private var username: String = ""  // NEWBEN: mis en com
//    @State private var password: String = ""  // NEWBEN: mis en com
    
    let gradientStart = Color(hex: "#94A684").opacity(0.7)
    let gradientEnd = Color(hex: "#94A684").opacity(0.0) // Fades to transparent
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    
    var body: some View {
        
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .top, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                authenticationHeader
                SignInTextfieldsView(viewModel: viewModel)
                signInButton
            }
            .padding(.horizontal, 40)
        }
        .onTapGesture {
            self.endEditing(true)  // This will dismiss the keyboard when tapping outside
        }
        .alert(viewModel.ErrorAlert.title, isPresented: $viewModel.displayAlert) {  // NEWBEN: error alert
            Button(role: .cancel) {} label: {
                Text("OK")
            }
        } message: {
            Text(viewModel.ErrorAlert.message)
        }
    }
}

private extension AuthenticationView {

    // MARK: - Header

    var authenticationHeader: some View {
        Group {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text("Welcome !")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
    }

    // MARK: - Textfields

    struct SignInTextfieldsView: View {
        @ObservedObject var viewModel: AuthenticationViewModel

        var body: some View {
            TextField("Adresse email", text: $viewModel.username)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
            
            SecureField("Mot de passe", text: $viewModel.password)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
        }
    }

    // MARK: - Sign in button

    var signInButton: some View {
        Button(action: {
            // Handle authentication logic here
            viewModel.login()
        }) {
            Text("Se connecter")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black) // You can also change this to your pastel green color
                .cornerRadius(8)
        }
    }
}

// MARK: - Preview

#Preview {
    AuthenticationView(viewModel: AuthenticationViewModel({
        
    }))
}
