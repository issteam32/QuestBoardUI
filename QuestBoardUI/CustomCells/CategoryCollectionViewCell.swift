//
//  CategoryCollectionViewCell.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 7/4/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func generateCell(_ category: Category)
    {
        nameLabel.text = category.name
        imageView.image = category.image
    }
}
