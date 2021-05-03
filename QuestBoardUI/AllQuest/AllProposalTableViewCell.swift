//
//  AllProposalTableViewCell.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 29/4/21.
//

import UIKit

class AllProposalTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var offer: UILabel!
    @IBOutlet weak var btnChatRef: UIButton!
    @IBOutlet weak var btnAcceptRef: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func generateCell(_ item: Proposal)
    {
        name.text = item.senderName
        lastMessage.text = item.lastMessage
        offer.text = item.offer
    }
    
}
