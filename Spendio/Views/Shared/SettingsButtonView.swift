//
//  FilterButtonView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-25.
//

import SwiftUI

struct SettingsButtonView: View {
    @State private var isShowingSheet: Bool = false
    var body: some View {
        Button {
            isShowingSheet.toggle()
        } label: {
            Image(systemName: "gearshape")
        }
        .sheet(isPresented: $isShowingSheet) {
            SettingsSheetView(isShowingSheet: $isShowingSheet)
        }
    }
}
