//
//  item.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 8/4/21.
//

import Foundation
import UIKit

//class Quest {
//    var id: String?
//    var categoryId: String?
//    var questType: String?
//    var title: String?
//    var description: String?
//    var reward:String?
//    var location:String?
//    var imageLinks: [String]?
//    var skillRequired: String?
//}

public class Quest {
    var awarded: Int?
    var awardedTo: String?
    var category: Int
    var categoryDesc: String?
    var createdDate: String?
    var description: String?
    var difficultyLevel: String?
    var id: Int?
    var location: String?
    var requestor: String?
    var reward: String?
    var rewardType: Int?
    var skillRequired: String?
    var status: String?
    var title: String?
    var updatedDate: String?
        
    public init() {
        self.category = 0
        self.rewardType = 0
        self.description = ""
        self.title = ""
        self.skillRequired = ""
        self.awarded = 0
        self.awardedTo = ""
        self.categoryDesc = ""
        self.location = ""
    }
    
    func printMyself() {
        let questMirror = Mirror(reflecting: self)
        let properties = questMirror.children
        for property in properties {
          print("\(property.label!) = \(property.value)")
        }
    }
}
