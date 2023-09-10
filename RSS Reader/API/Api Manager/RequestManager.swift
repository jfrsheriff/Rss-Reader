//
//  RequestManager.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

protocol RequestManagerProtocol {
    func perform(_ request: APIRequestProtocol) async throws -> Data
    func downloadImage(from urlStr: String) async throws -> Data
}

class RequestManager : RequestManagerProtocol {
    let apiManager : APIManagerProtocol
        
    init(apiManager : APIManagerProtocol = APIManager()){
        self.apiManager = apiManager
    }
    
    func perform(_ request: APIRequestProtocol) async throws -> Data {
        let data = try await apiManager.perform(request: request)
        return data
    }
    
    func downloadImage(from urlStr: String) async throws -> Data {
        return try await apiManager.downloadImage(from: urlStr)
    }
    
}


