//
//  RSS_ReaderApp.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import SwiftUI

@main
struct RSS_ReaderApp: App {
    
    var body: some Scene {
        WindowGroup {
            ViewFactory.getRssHomeView()
        }
    }
}
