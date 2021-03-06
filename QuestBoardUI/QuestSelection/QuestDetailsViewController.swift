//
//  QuestDetailsViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 21/4/21.
//

import UIKit

class QuestDetailsViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lbLocation: UILabel!
    
    @IBOutlet weak var lbSkill: UILabel!
    
    @IBOutlet weak var lbReward: UILabel!
    
    @IBOutlet weak var AcceptLabel: UIButton!
    
    var quest:Quest!
    var isNew:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(quest.id)")
        //send quest id to WS to get info
                    
        lbName.text = quest.title
        tvDescription.text = quest.description
        lbLocation.text = quest.location
        lbSkill.text = quest.skillRequired
        lbReward.text = quest.reward
        
        if(isNew == false)
        {
            AcceptLabel.isHidden = true
        }
        
    }
        

    @IBAction func btnPropose(_ sender: Any) {
        
    }
    
    @IBAction func btnChat(_ sender: Any) {
    }
    
    @IBAction func btnProfile(_ sender: Any) {
    }
}
