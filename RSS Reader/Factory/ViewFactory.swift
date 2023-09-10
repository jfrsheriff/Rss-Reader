//
//  ViewFactory.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 07/09/23.
//

import SwiftUI

enum ViewFactory {
    
    static func getRssHomeView() -> some View{
        let vm = RSSReaderViewModel()
        let homeView = RssListingHomeView(viewModel: vm)
        return homeView
    }
    
}
