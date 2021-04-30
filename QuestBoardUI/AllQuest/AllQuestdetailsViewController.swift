//
//  AllQuestdetailsViewController.swift
//  QuestBoardUI
//
//  Created by Adam Tan on 30/4/21.
//

import UIKit

class AllQuestdetailsViewController: UIViewController {

    //var quest = Quest()
    var questArray: [Quest] = [Quest]()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var skillRequired: UILabel!
    @IBOutlet weak var reward: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setQuest()
       

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
                                self.questArray.append(q)
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
                        self.questArray.append(questObject)
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
    
    
    func setQuest()
    {
//        name.text = questArray[0].title
//        desc.text = questArray[0].description
//        location.text = questArray[0].location
//        skillRequired.text = questArray[0].skillRequired
//        reward.text = questArray[0].reward
        
        name.text = "Quest 2"
        desc.text =  "I need someone to help me queue for the latest iphone"
        location.text = "Orchard Apple store"
        skillRequired.text = "No skill required"
        reward.text = "$20"
        
    }
}
