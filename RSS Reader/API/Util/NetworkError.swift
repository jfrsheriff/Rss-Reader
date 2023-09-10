//
//  NetworkError.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

enum NetworkError : Error{
    case invalidUrl
    case invalidServerResponse
    
    var description : String{
        switch self {
            case .invalidUrl:
                return "Url String is Invalid"
            case .invalidServerResponse:
                return "Server Returned Invalid Response"
        }
    }
}
