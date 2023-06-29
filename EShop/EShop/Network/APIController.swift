//
//  APIController.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Foundation

protocol APIRepo {
    func getCategories() async -> [Category]?
    func getProductsByCategory(categoryId: Int) async -> [Product]?
}

class APIController: APIRepo {
    
    private var api = APIManager.shared
    
    private func parseData<T: Decodable>(data: Data) throws -> [T] {
        guard let decodeData = try? JSONDecoder().decode([T].self, from: data) else {
            throw NetworkError.decodingError
        }
        return decodeData
    }
    
    func getCategories() async -> [Category]? {
        do {
            let data = try await api.request(request: RequestObjectModel(method: .get, path: URL.allCategories))
            let result: [Category] = try self.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getProductsByCategory(categoryId: Int) async -> [Product]? {
        do {
            let data = try await api.request(request: RequestObjectModel(method: .get, path: URL.productsByCategory(categoryId)))
            let result: [Product] = try self.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

class MockAPIRepo: APIRepo {
    var categories: [Category]?
    var products: [Product]?
    
    func getCategories() async -> [Category]? {
        return categories
    }
    
    func getProductsByCategory(categoryId: Int) async -> [Product]? {
        return products
    }
}
