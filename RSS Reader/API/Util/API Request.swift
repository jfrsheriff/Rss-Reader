//
//  API Request.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

protocol APIRequestProtocol {
    
    var path : String { get }

    var requestHeader : [String : String] { get }
    var requestParam : [String : Any] { get }
    
    var urlQuery : [String : String] { get }
    
    var requestType : RequestType { get }
    
    var shouldIncludeAuthenticationToken : Bool { get }
    
    func getURLRequest(token : String) throws -> URLRequest
}


extension APIRequestProtocol {
    var host : String {
        APIConstants.host
    }
    var path : String{
        ""
    }
    
    var requestHeader : [String : String] {
        [:]
    }
    
    var requestParam : [String : Any] {
        [:]
    }
    
    var urlQuery : [String : String] {
        [:]
    }
    
    var requestType : RequestType {
        .GET
    }
    
    var shouldIncludeAuthenticationToken : Bool {
        true
    }
}

extension APIRequestProtocol{
    
    func getURLRequest(token : String = "") throws -> URLRequest {
        var urlComponenets = URLComponents()
        urlComponenets.scheme = APIConstants.scheme
        urlComponenets.host = host
        urlComponenets.path = path
        urlComponenets.queryItems = urlQuery.map{
            URLQueryItem(name: $0, value: $1)
        }
        
        guard let url = urlComponenets.url else { throw NetworkError.invalidUrl }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !requestHeader.isEmpty{
            urlRequest.allHTTPHeaderFields = requestHeader
        }
        
        if !requestParam.isEmpty{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestParam)
        }
        
        if shouldIncludeAuthenticationToken{
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }    
}
