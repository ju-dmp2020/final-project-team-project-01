//
//  CategoryRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct CategoryRowView: View {
    let category: String
    var body: some View {
        HStack {
            Image(systemName: "photo")
            Text(category)
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: "Coffee")
    }
}
