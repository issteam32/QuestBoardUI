//
//  QuestTableViewCell.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 19/4/21.
//

import UIKit

class QuestTableViewCell: UITableViewCell {

    @IBOutlet weak var questName: UILabel!
    
    @IBOutlet weak var questDescription: UILabel!
    
    @IBOutlet weak var questReward: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func generateCell(_ item: Item)
    {
        
        questName.text = item.name
        questDescription.text = item.description
        questReward.text = item.reward
        
    }

}
