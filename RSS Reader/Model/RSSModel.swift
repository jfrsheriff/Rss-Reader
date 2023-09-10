//
//  RSSModel.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

// MARK: - RSSModel
struct RSSModel  {
    let rss: RSS
}

// MARK: - RSS
struct RSS {
    let channel: Channel
}

// MARK: - Channel
struct Channel {
    let title: String
    let item: [Item]
}


// MARK: - Item
struct Item: Identifiable {
    let id: UUID
    let title: String
    let link: String
    let imageURL: URL?
    
    init(id: UUID = UUID(), title: String, link: String, imageURL: URL?) {
        self.id = id
        self.title = title
        self.link = link
        self.imageURL = imageURL
    }
}

enum RSSReaderModelXMLKeys{
    static let rss = "rss"
    static let channel = "channel"
    static let title = "title"
    static let description = "description"
    static let link = "link"
    static let item = "item"
    static let content_encoded = "content:encoded"
    static let img = "img"
    static let figure = "figure"
}

