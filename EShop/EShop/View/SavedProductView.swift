//
//  SavedProductView.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import SwiftUI

struct SavedProductView: View {
    @EnvironmentObject var shopModel: ShopModel
    
    var body: some View {
        NavigationStack {
            List(shopModel.savedProducts, id: \.id) { product in
                ProductCellView(product: product)
            }
            .listStyle(.plain)
            .task {
                await shopModel.getSavedProducts()
            }.navigationTitle("Saved Products")
        }
    }
}

struct SavedProductView_Previews: PreviewProvider {
    static var previews: some View {
        SavedProductView().environmentObject(ShopModel())
    }
}
