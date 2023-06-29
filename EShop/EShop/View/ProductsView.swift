//
//  ProductsView.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import SwiftUI

struct ProductsView: View {
    
    let category: Category
    @EnvironmentObject private var shopModel: ShopModel
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isShowingDialog = false
    
    var filteredCategory: [Product] {
        if searchText.isEmpty {
            return shopModel.products
        } else {
            return shopModel.products.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        }
    }
        
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, isSearching: $isSearching)
            List(filteredCategory, id: \.id) { product in
                ProductCellView(product: product)
                    .onTapGesture {
                        shopModel.saveProduct(product: product)
                        isShowingDialog = true
                    }
                    .alert(isPresented: $isShowingDialog) {
                        Alert(title: Text("Info"), message: Text("You save the product"))
                    }
            }
            .listStyle(.plain)
            .task {
                do {
                    try await shopModel.fetchProductsByCategory(categoryId: category.id)
                } catch {
                    print(error.localizedDescription)
                }
            }.navigationTitle(category.name)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductsView(category: Category.preview).environmentObject(ShopModel())
        }
    }
}
