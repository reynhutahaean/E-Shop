//
//  APIManager.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import Alamofire

enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidURL
}

class APIManager {
    
    static var shared = APIManager()
    
    func request(request: RequestObjectModel) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(URL.baseURL)\(request.path)", method: .get).responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
