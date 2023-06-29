//
//  DataManager.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Foundation

struct DataConstant {
    
    struct Defaults {
        struct Keys {
            static let products = "products"
        }
    }
}

class DataManager {
    
    struct Defaults {
        private let defaults = UserDefaults.standard

        func setDataObject<T: Encodable>(object: T, key: String) {
            if let dataEncoded = try? JSONEncoder().encode(object) {
                defaults.set(dataEncoded, forKey: key)
            } else {
                print("Failed to encode")
            }
        }
        
        func getDataObject<T: Decodable>(object: T.Type, key: String, completion: @escaping (T?) -> Void) {
            if let dataEncoded = defaults.object(forKey: key) as? Data {
                let data = try? JSONDecoder().decode(object.self, from: dataEncoded)
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
}
