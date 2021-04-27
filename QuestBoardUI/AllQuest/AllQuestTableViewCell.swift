//
//  AllQuestTableViewCell.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 26/4/21.
//

import UIKit

class AllQuestTableViewCell: UITableViewCell {

    @IBOutlet weak var statusColor: UIView!
    @IBOutlet weak var questName: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var questDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateCell(_ item: Quest)
    {
        print(item.status)
        item.requestor = "123"
        if(item.status == "Posted") // the current user posted
        {
            statusColor.backgroundColor = UIColor.green
            status.text = "Poted"
        }
        else if(item.status == "Taken") //the current user taken de quest
        {
            statusColor.backgroundColor = UIColor.blue
            status.text = "Taken"
        }
        
        questName.text = item.title
        questDescription.text = item.description
    }

}
