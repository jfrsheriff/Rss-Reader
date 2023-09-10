//
//  RssFeedRequest.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

struct RssFeedRequest : APIRequestProtocol {
    
    var path: String{
        "/feed/backchannel"
    }
    
    var shouldIncludeAuthenticationToken: Bool{
        false
    }
}
