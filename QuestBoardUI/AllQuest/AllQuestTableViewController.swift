//
//  AllQuestTableViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 26/4/21.
//

import UIKit
import ProgressHUD

class AllQuestTableViewController: UITableViewController {

    
    var questArray: [Quest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadQuest()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadQuest()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return questArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllQuestTableViewCell
        
        cell.generateCell(questArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(questArray[indexPath.row].status == "Taken")
        {
            showQuestView(questArray[indexPath.row])
        }
        
        else
        {
            showProposeView(questArray[indexPath.row])
        }
       
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func showQuestView(_ item: Quest)
    {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "questDetails") as! QuestDetailsViewController
        
        questVC.quest = item
        questVC.isNew = false
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    func showProposeView(_ item: Quest)
    {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "allQuestDetails") as! AllQuestdetailsViewController
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    
    func loadQuest()
    {
//        NetworkManager.call(url:  "/get-user-quest" , json: ["type": "requestor"],  Completion: { (responseJSON) in
//                            print(responseJSON)
//            print("test")
//                        })
//
        ProgressHUD.show("Loading your quests...")
        let parameters: [String : String] = ["type": "requestor"]
        
        NetworkManager.call(url: "/get-user-quest", json: parameters, Completion: {(response) in
//            print(response["result"])
            if let respJSON = response["result"] as? [Any] {
                self.questArray = [Quest]()
                print(respJSON)
                guard let jsonArray = respJSON as? [[String: Any]] else {
                      return
                }
                print("###############################")
                print(jsonArray)
                for dic in jsonArray {
                    print("inside")
                    print(dic)
                    var quest = Quest()
                    quest.id = dic["id"] as? Int
                    quest.awarded = dic["awarded"] as? Int
                    quest.awardedTo = dic["awardedTo"] as? String
                    quest.category = dic["category"] as! Int
                    quest.categoryDesc = dic["categoryDesc"] as? String
                    quest.createdDate = dic["createdDate"] as? String
                    quest.description = dic["description"] as? String
                    quest.difficultyLevel = dic["difficultyLevel"] as? String
                    quest.location = dic["location"] as? String
                    quest.requestor = dic["requestor"] as? String
                    quest.reward = dic["reward"] as? String
                    quest.rewardType = dic["rewardType"] as? Int
                    quest.skillRequired = dic["skillRequired"] as? String
                    quest.status = dic["status"] as? String
                    quest.title = dic["title"] as? String
                    quest.updatedDate = dic["updatedDate"] as? String
                    
                    self.questArray.append(quest)
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    ProgressHUD.dismiss()
                }
            }
        })
        
//
//        let quest1 = Quest()
//        quest1.id = 2
//        quest1.title = "Quest2"
//        quest1.category = 0
//        quest1.description = "This is the description for quest2. Some help needed for XXXXXX location is at XXXXX"
//        quest1.reward = "3000"
//        quest1.location = "Some where in yishun"
//        quest1.skillRequired = "Nil"
//        quest1.status = "Posted"
//
//
//        let quest2 = Quest()
//        quest2.id = 6
//        quest2.title = "Quest6"
//        quest2.category = 0
//        quest2.description = "This is the description for quest6. Some help needed for XXXXXX location is at XXXXX"
//        quest2.reward = "5000"
//        quest2.location = "Some where in Serangoon"
//        quest2.skillRequired = "Able to stand very long"
//        quest2.status = "Posted"
//
//
//        let quest3 = Quest()
//        quest3.id = 7
//        quest3.title = "Quest7"
//        quest3.category = 0
//        quest3.description = "This is the description for quest7. Some help needed for XXXXXX location is at XXXXX"
//        quest3.reward = "1000"
//        quest3.location = "Some where in Bishan"
//        quest3.skillRequired = "Able to run"
//        quest3.status = "Taken"
//
//
//        questArray.append(quest1)
//        questArray.append(quest2)
//        questArray.append(quest3)
    }

    

}
