//
//  FilterSheetView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-25.
//

import SwiftUI

struct SettingsSheetView: View {
    @Binding var isShowingSheet: Bool
    @ObservedObject var settingsViewModel = SettingsViewModel.shared
    var body: some View {
        VStack {
            HStack {
                Toggle("Require auth on startup", isOn: $settingsViewModel.useAuthentication)
                
            }
            Spacer()
            Button {
                isShowingSheet.toggle()
            } label: {
                Text("Dismis")
            }
        }
        .padding()
    }
}
