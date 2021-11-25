//
//  FilterSheetView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-25.
//

import SwiftUI

struct FilterSheetView: View {
    @Binding var isShowingSheet: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button {
            isShowingSheet.toggle()
        } label: {
            Text("Dismis")
        }

    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView(isShowingSheet: .constant(false))
    }
}
