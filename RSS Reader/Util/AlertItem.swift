//
//  AlertItem.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 10/09/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    //Fetch Error Message
    static let fetchingError      = AlertItem(title: Text("Error"),
                                              message: Text("There is some problem in Feching the Rss Feed Data. Please try again or contact support."),
                                              dismissButton: .default(Text("Ok")))
}
