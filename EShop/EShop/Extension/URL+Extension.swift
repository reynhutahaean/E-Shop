//
//  URL+Extension.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Foundation

extension URL {
    static var baseURL: URL {
        URL(string: "https://api.escuelajs.co")!
    }
    
    static var allCategories: URL {
        URL(string: "/api/v1/categories")!
    }
    
    static func productsByCategory(_ categoryId: Int) -> URL {
        return URL(string: "/api/v1/categories/\(categoryId)/products")!
    }
}
