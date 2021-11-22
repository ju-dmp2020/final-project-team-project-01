//
//  APIErrorView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import SwiftUI

struct APIErrorView: View {
    @Binding var thrownError: String?
    var body: some View {
        Text(thrownError!)
            .font(.headline)
            .padding()
    }
}

struct APIErrorView_Previews: PreviewProvider {
    static var previews: some View {
        APIErrorView(thrownError: .constant("Invalid URL"))
    }
}
