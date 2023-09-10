//
//  DataParser.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 06/09/23.
//

import Foundation
import SwiftyXMLParser

class RssReaderDataParser{
    func parse(_ data: Data) throws -> RSSModel? {

        let xml = XML.parse(data) // -> XML.Accessor
        let itemsXml = xml[RSSReaderModelXMLKeys.rss][RSSReaderModelXMLKeys.channel][RSSReaderModelXMLKeys.item]
        var items: [Item] = []
        for itemXml in itemsXml{
            guard let titleData = itemXml[RSSReaderModelXMLKeys.title].element?.CDATA, let titleStr = String(data: titleData, encoding: .utf8)  else {continue}
            let link = itemXml[RSSReaderModelXMLKeys.link].text ?? ""
            guard let contentEncodedCData = itemXml[RSSReaderModelXMLKeys.content_encoded].element?.CDATA else {continue}
            let contentEncodedCDataString = String(decoding: contentEncodedCData, as: UTF8.self)
            let figureTagUrlStr = getMatchingValueFrom(strXML: contentEncodedCDataString, tag: RSSReaderModelXMLKeys.figure)
            let imgUrl = getUrlStr(figureTagUrlStr)
            let item = Item(title: titleStr, link: link, imageURL: URL(string: imgUrl))
            items.append(item)
        }
        guard let data = xml[RSSReaderModelXMLKeys.rss][RSSReaderModelXMLKeys.channel][RSSReaderModelXMLKeys.title].element?.CDATA else {return nil}
        let titleStr = String(data:data , encoding: .utf8) ?? ""
        let channel = Channel(title: titleStr, item: items)
        let rss = RSS(channel: channel)
        let rssModel = RSSModel(rss: rss)
        return rssModel
    }
    
    
    
    private func getUrlStr(_ sourceStr: String) -> String{
        let pattern : String = "<img[^>]*src=\"([^\"]+)\"[^>]*>"
        return getMatchingValueFrom(sourceStr: sourceStr, pattern: pattern)
    }
    
    private func getMatchingValueFrom(strXML:String, tag:String) -> String {
        let pattern : String = "<"+tag+">(.*?)</"+tag+">"
        return getMatchingValueFrom(sourceStr: strXML, pattern: pattern)
    }
    
    private func getMatchingValueFrom(sourceStr: String, pattern: String) -> String {
        guard !pattern.isEmpty else {return ""}
        let regexOptions = NSRegularExpression.Options.caseInsensitive
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: regexOptions)
            guard let textCheckingResult : NSTextCheckingResult = regex.firstMatch(in: sourceStr, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0, sourceStr.count)) else {return ""}
            let matchRange : NSRange = textCheckingResult.range(at: 1)
            let match : String = (sourceStr as NSString).substring(with: matchRange)
            return match
        } catch {
            print(pattern + "<-- not found in string -->" + sourceStr )
            return ""
        }
    }

}
