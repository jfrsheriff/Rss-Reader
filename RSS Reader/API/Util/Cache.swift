//
//  Cache.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

protocol CacheProtocol {
    func save(data : Data , forKey urlStr: String)
    func getData(forKey urlStr : String) -> Data?
}


final class Cache : CacheProtocol{
    
    static let shared = Cache()
    
    private let cache = NSCache<NSString,NSData>()
    
    private init(){}
    
    
    func save(data : Data , forKey urlStr: String) {
        let cacheKey = NSString(string: urlStr)
        self.cache.setObject(NSData(data: data), forKey: cacheKey)
    }
    
    
    func getData(forKey urlStr : String) -> Data? {
        let cacheKey = NSString(string: urlStr)
        if let data = cache.object(forKey: cacheKey)  {
            return Data(data)
        }
        return nil
    }
}
