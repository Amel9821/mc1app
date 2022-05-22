//
//  ReadingModel.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 17/05/22.
//

import Foundation
import SwiftUI

struct ReadingListModel: Identifiable {
    var id = UUID()
    
    // mandatory to add reading list
    var title: String
    var author: String
    var category: [String]
    var categoryColor: [Color]
    
    
    // not mandatory
    
    // image
    var image: String?
    
    
    var purpose: String?
    var highlights: [String]?
    var actionableTakeways: [String]?
}
