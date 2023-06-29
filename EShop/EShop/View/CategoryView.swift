//
//  CategoryView.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var shopModel: ShopModel
    @State private var errorMessage = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List(shopModel.categories, id: \.id) { category in
                    NavigationLink(value: category) {
                        HStack {
                            AsyncImage(url: category.image) { image in
                                image.resizable()
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            } placeholder: {
                                ProgressView()
                            }
                            Text(category.name)
                        }
                    }
                    
                }.navigationDestination(for: Category.self, destination: { category in
                    ProductsView(category: category)
                })
                .task {
                    do {
                        try await shopModel.fetchAllCategories()
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }.navigationTitle("Shop")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresented = true
                        }) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }.sheet(isPresented: $isPresented) {
                            SavedProductView()
                        }
                    }
                }
        }
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView().environmentObject(ShopModel())
    }
}
