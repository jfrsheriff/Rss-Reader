//
//  RSSReaderViewModel.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation

class RSSReaderViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var itemsData: [Data] = []
    @Published var modelTitle: String = ""
    @Published var isLoading: Bool = true
    @Published var errorOccured: Bool = false
    
    
    var selectedItem: Item? = nil
    
    private var rssModel: RSSModel?
    private let request: APIRequestProtocol
    private let manager: RequestManagerProtocol
    private let parser: RssReaderDataParser
    
    
    init(rssModel: RSSModel? = nil,
         request: APIRequestProtocol = RssFeedRequest(),
         manager: RequestManagerProtocol = RequestManager(),
         parser: RssReaderDataParser = RssReaderDataParser()) {
        self.rssModel = rssModel
        self.request = request
        self.manager = manager
        self.parser = parser
    }
    
    func fetchData(){
        Task{
            do{
                let xmlData = try await manager.perform(request)
                let model = try parser.parse(xmlData)
                await updateModel(model)
            }catch{
                await triggerErrorDisplay()
                print(error.localizedDescription)
            }
        }
    }
    
    
    @MainActor
    private func updateModel(_ model: RSSModel?){
        self.isLoading = false
        self.rssModel = model
        if let itemsFromModel = rssModel?.rss.channel.item{
            self.items = itemsFromModel
        }
        self.modelTitle = self.rssModel?.rss.channel.title ?? ""
    }
    
    @MainActor
    private func triggerErrorDisplay(){
        self.errorOccured = true
    }
}
