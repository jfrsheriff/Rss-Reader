//
//  RssListingHomeView.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 07/09/23.
//

import SwiftUI

struct RssListingHomeView: View {
    @ObservedObject var viewModel: RSSReaderViewModel
    @State private var showSafariView : Bool = false
    
    var body: some View {
        ZStack{
            if viewModel.errorOccured{
                ErrorView(title: AlertContext.fetchingError.title,
                          message: AlertContext.fetchingError.message,
                          isErrorOccured: $viewModel.errorOccured)
            }else{
                NavigationView {
                    List(viewModel.items) { item in
                        RssListCell(item)
                        
                            .onTapGesture {
                                viewModel.selectedItem = item
                                showSafariView = true
                            }
                        
                            .sheet(isPresented: $showSafariView,
                                   content: {
                                if let urlStr = viewModel.selectedItem?.link, let url = URL(string: urlStr){
                                    RssDetailView(url: url)
                                }
                            })
                    }
                    .onAppear(){
                        viewModel.fetchData()
                    }
                    .navigationTitle(viewModel.modelTitle)
                    .refreshable {
                        viewModel.fetchData()
                    }
                }
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
    }
}

struct RssListingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RSSReaderViewModel()
        RssListingHomeView(viewModel: vm)
    }
}
