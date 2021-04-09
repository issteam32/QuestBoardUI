//
//  Category.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 8/4/21.
//

import Foundation
import UIKit

class Category{
    
    
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    
    init(_name: String , _imageName: String) {
        
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    
    }
    
    init(_dictionary: NSDictionary) {
        
        id = _dictionary["objectId"] as! String
        name = _dictionary["name"] as! String
        image = UIImage(named: _dictionary["imageName"] as? String ?? "")
    }
    
    
    //To download category from DB
    func downloadCategoryFromDb()
    {
        
        var categoryArray: [Category] = []
        //too call webservice to download category
        let cat1 = Category(_name: "Walk the dog", _imageName: "dog")
        categoryArray.append(cat1)
    }
    
    //sample create
    //let walkDog = Category(_name: "Walk the Dog", _imageName: "dog")
    
}



