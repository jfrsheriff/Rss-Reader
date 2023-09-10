//
//  RssListCell.swift
//  RSS Reader
//
//  Created by Jaffer Sheriff U on 10/09/23.
//

import SwiftUI

struct RssListCell: View{
    let item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    var body: some View{
        HStack(spacing:5){
            Text(item.title)
                .fontWeight(.regular)
                .foregroundColor(.primary)
                .padding(.all, 0)
                .font(.headline)
                .frame(maxHeight:100)
            Spacer()
            
            if let imageUrl = item.imageURL  {
                AsyncImage(url: imageUrl)
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
            }else{
                Image(systemName: "photo")
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
            }
        }
        
    }
}
