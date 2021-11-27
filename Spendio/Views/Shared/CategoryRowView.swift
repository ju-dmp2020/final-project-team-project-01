//
//  CategoryRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct CategoryRowView: View {
    let categoryName: String
    let categoryColor: Color
    var body: some View {
        HStack {
            Circle()
                .fill(categoryColor)
                .frame(width: 15, height: 15)
            Text(categoryName)
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(categoryName: "Coffee", categoryColor: .brown)
    }
}
