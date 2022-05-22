//
//  BookCardView.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 20/05/22.
//

import Foundation
import SwiftUI


struct BookCardView: View {
    let bookTitle: String
    let bookAuthor: String
    let firstTag: String
    let firstTagColor: Color
    let numOfTag: Int
    let insight: String
    
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(bookTitle)
                    .font(.title3)
                
                Spacer()
                
                Text(bookAuthor)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(spacing: 5){
                    TagView(tagText: firstTag, tagColor: firstTagColor)
                    TagView(tagText: "+ \(numOfTag - 1)", tagColor: Color.secondary)
                        .opacity(numOfTag < 2 ? 0: 1)
                    Spacer()
                }
                
                Spacer()
                Text("Insight 💡")
                    .font(.subheadline)
                
                
                Spacer()
                // this is insight preview
                Text("\"\(insight)\"")
                    .font(.body.italic())
                    .lineLimit(2)
                
            }
            
            VStack {
                Image("atomic_habit")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                
                Spacer()
                
                Button {
                    // go to detail view
                    
                    
                } label: {
                    Text("See all")
                        .font(.footnote)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.2)
        }
    }
}
