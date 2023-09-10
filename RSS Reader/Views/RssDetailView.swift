//
//  RssDetailView.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 10/09/23.
//

import SwiftUI
import SafariServices

struct RssDetailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url : URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let sfViewController = SFSafariViewController.init(url: url)
        return sfViewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

struct ARssDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RssDetailView(url: URL(string: "https://www.google.co.in/")!)
    }
}
