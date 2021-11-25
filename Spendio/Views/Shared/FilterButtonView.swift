//
//  FilterButtonView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-25.
//

import SwiftUI

struct FilterButtonView: View {
    @State private var isShowingSheet: Bool = false
    var body: some View {
        Button {
            isShowingSheet.toggle()
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
        .sheet(isPresented: $isShowingSheet) {
            FilterSheetView(isShowingSheet: $isShowingSheet)
        }
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView()
    }
}
