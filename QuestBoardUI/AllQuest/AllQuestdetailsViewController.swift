//
//  AllQuestdetailsViewController.swift
//  QuestBoardUI
//
//  Created by Adam Tan on 30/4/21.
//

import UIKit

class AllQuestdetailsViewController: UIViewController {

    //var quest = Quest()
    var quest: Quest = Quest()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var skillRequired: UILabel!
    @IBOutlet weak var reward: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initQuestView()
    }
    
    
    func loadQuest()
    {
        let parameters: [String : String] = ["type": "requestor"]
        
        NetworkManager.call(url: "/get-user-quest", json: parameters, Completion: {(response) in
            if let questJson = response as? [Any] {
                for ss in questJson {
                    if let quest = ss as? [String: Any] {
                        let questObject = Quest()
                        for (key, value) in quest {
                            if let q = value as? Quest {
//                                self.questArray.append(q)
                            } else {
                                print("cast failed")
                            }
                            print(key)
                            print(value)
//                            let ssp = value as! [String: Any]
//                                print(value)
//                                questObject.id = ssp["id"] as? Int
//                                questObject.title = ssp["title"] as? String
//                                questObject.description = ssp["skill"] as? String
//                                questObject.location = ssp["location"] as? String
//                                questObject.skillRequired = ssp["skillRequired"] as? String
//                                questObject.location = ssp["reward"] as? String
//
                        }
//                        self.questArray.append(questObject)
                    }
                }
                
            }
        })
    }
    
    
    @IBAction func btnviewAllProposal(_ sender: Any) {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "allProposal") as! AllProposalTableViewController
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    
    func initQuestView()
    {
        name.text = quest.title
        desc.text =  quest.description
        location.text = quest.location
        skillRequired.text = (quest.category == 1) ? quest.skillRequired : "No skill required"
        reward.text = "\(quest.reward as? String)"
        
    }
}
