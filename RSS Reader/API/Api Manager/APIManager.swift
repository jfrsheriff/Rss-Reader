//
//  APIManager.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

protocol APIManagerProtocol {
    func perform(request : APIRequestProtocol) async throws -> Data
    func requestToken() -> String
    func downloadImage(from urlStr: String) async throws -> Data
}


class APIManager : APIManagerProtocol{
    
    private let urlSession : URLSession
    private let cache : CacheProtocol
    
    
    init(withSession session : URLSession = URLSession.shared , cache : CacheProtocol = Cache.shared){
        urlSession = session
        self.cache = cache
    }
    
    
    func perform(request : APIRequestProtocol) async throws -> Data{
        let urlReq = try request.getURLRequest(token: requestToken())
        
        let (data, response) = try await urlSession.data(for: urlReq)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
    
    
    func requestToken() -> String {
        return ""
    }
    
    
    func downloadImage(from urlStr: String) async throws -> Data {
        if let data = cache.getData(forKey: urlStr) {
            return data
        }
        guard let url = URL(string: urlStr) else {throw NetworkError.invalidUrl}
        let urlReq = URLRequest(url: url)
        
        let (data, response) = try await urlSession.data(for: urlReq)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        cache.save(data: data, forKey: urlStr)
        return data
    }
    
}
