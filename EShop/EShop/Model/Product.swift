//
//  Product.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Foundation

struct Product: Codable {
    var id: Int?
    let title: String
    let price: Double
    let description: String
    let category: Category
}

extension Product {
    static var preview: Product {
        Product(id: 1, title: "Clothes", price: 854, description: "Alpapapapapapa....", category: Category.preview)
    }
}
