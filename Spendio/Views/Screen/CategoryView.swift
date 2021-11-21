//
//  CategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct CategoryView: View {
    let category: String
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // EmptyView will be replaced with an actual view
            NavigationLink(destination: EmptyView()) {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Test")
    }
}
