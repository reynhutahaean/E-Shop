//
//  SearchBar.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $searchText)
                .padding(.leading, 5)
            
            Button(action: {
                searchText = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText.isEmpty ? 0 : 1)
            })
            .padding(.trailing, 5)
            .animation(.default, value: 1)
            
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
    }
}
