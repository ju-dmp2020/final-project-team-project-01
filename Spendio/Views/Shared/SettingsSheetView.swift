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
            Text("Settings")
                .font(.title)
                .padding(8)
            
            Toggle("Require authentication on startup", isOn: $settingsViewModel.useAuthentication)
                .padding(4)
 
            HStack{
                Text("Base currency")
                Spacer()
                Picker("Currency", selection: $settingsViewModel.baseCurrency) {
                    Text("None").tag(nil as String?)
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Text(currency.rawValue)
                            .tag(currency.rawValue as String?)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding(4)
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
