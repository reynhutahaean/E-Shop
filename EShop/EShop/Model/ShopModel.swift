//
//  ShopModel.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Foundation

class ShopModel: ObservableObject {
    @Published private(set) var categories: [Category] = []
    @Published private(set) var products: [Product] = []
    @Published private(set) var savedProducts: [Product] = []
    @Published var errorMessage = ""
    var service: APIRepo = APIController()
    
    func fetchAllCategories() async throws {
        let response = await service.getCategories() ?? []
        
        DispatchQueue.main.async {
            self.categories = response
        }
    }
    
    func fetchProductsByCategory(categoryId: Int) async throws {
        let response = await service.getProductsByCategory(categoryId: categoryId) ?? []
        
        DispatchQueue.main.async {
            self.products = response
        }
    }
    
    func saveProduct(product: Product) {
        savedProducts.append(product)
        DataManager.Defaults().setDataObject(object: savedProducts, key: DataConstant.Defaults.Keys.products)
    }
    
    func getSavedProducts() async {
        DataManager.Defaults().getDataObject(object: [Product].self, key: DataConstant.Defaults.Keys.products) { [weak self] products in
            DispatchQueue.main.async { [weak self] in
                self?.savedProducts = products ?? []
            }
        }
    }
}
