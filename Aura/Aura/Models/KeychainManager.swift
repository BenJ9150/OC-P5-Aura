//
//  KeychainManager.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 25/01/2024.
//

import Foundation
import Security

final class KeychainManager {

    // MARK: Public properties

    static var userIsLogged: Bool {
        return getTokenFromKeychain() != ""
    }

    static var token: String {
        get {
            if currentToken == nil {
                currentToken = getTokenFromKeychain()
            }
            return currentToken!
        } set {
            saveInKeychain(token: newValue)
        }
    }

    // MARK: Private properties

    private static var currentToken: String?
    private static let keychainTokenAccount = "AuraTokenAccount"
}

// MARK: Public method

extension KeychainManager {

    static func deleteTokenInKeychain() {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainTokenAccount
        ]
        // Find token and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("Token removed successfully from keychain")
        } else {
            print("Something went wrong trying to remove token from keychain")
        }
        // change token state
        currentToken = nil
    }
}

// MARK: Private methods

private extension KeychainManager {

    static func getTokenFromKeychain() -> String {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainTokenAccount,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        // Check if data exists in the keychain
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let token = String(data: data, encoding: .utf8) {
                return token
            }
        }
        print("Token not stored in keychain")
        return ""
    }

    static func saveInKeychain(token: String) {
        // check if token already saved
        if getTokenFromKeychain() != "" {
            updateInKeychain(token: token)
            return
        }
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainTokenAccount,
            kSecValueData as String: token.data(using: .utf8)!
        ]
        // Store the token
        if SecItemAdd(query as CFDictionary, nil) == noErr {
            print("Token saved successfully in keychain")
            currentToken = token
        } else {
            print("Something went wrong trying to save token in keychain")
            currentToken = ""
        }
    }

    static func updateInKeychain(token: String) {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainTokenAccount
        ]
        // Set attributes for the new token
        let attributes: [String: Any] = [kSecValueData as String: token.data(using: .utf8)!]
        // Find data and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            currentToken = token
        } else {
            print("Something went wrong trying to update token in keychain")
            currentToken = ""
        }
    }
}
