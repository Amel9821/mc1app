//
//  ReadingListManager.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 17/05/22.
//

import Foundation
import SwiftUI


struct ReadingListManager {
    
    // array of Reading model
    var list: [ReadingListModel] = []
    
    
    mutating func addReadingList(data: ReadingListModel) {
        // MARK: add reading list here
        self.list.append(data)
    }
    
    
    mutating func deleteReadingList(index: Int) {
        // MARK: delete reading list data based on index
        self.list.remove(at: index)
    }
    
    func getIndex(id: UUID) -> Int {
        var index = 0
        
        for (arrIndex, _) in list.enumerated() {
            if id == list[arrIndex].id {
                index = arrIndex
            }
        }
        
        return index
    }
    
    func getReadingListByIndex(index: Int) -> ReadingListModel {
        return list[index]
    }
    
    
}
