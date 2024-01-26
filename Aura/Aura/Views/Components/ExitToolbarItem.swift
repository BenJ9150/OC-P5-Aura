//
//  ExitToolbarItem.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 26/01/2024.
//

import SwiftUI

func exitToolbarItem(_ action: @escaping () -> ()) -> ToolbarItem<(), some View> {
    return ToolbarItem(placement: .topBarTrailing) {
        Button("Exit") {
            action()
        }
        .foregroundStyle(Color(hex: "#94A684"))
    }
}
