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
        else if (questArray[indexPath.row].status == "Proposed")
        {
            showProposeView(questArray[indexPath.row])
        } else {
            showQuestView(questArray[indexPath.row])
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
        questVC.quest = item
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    
    func loadQuest()
    {
        ProgressHUD.show("Loading your quests...")
        let parameters: [String : String] = ["type": "requestor"]
        
        NetworkManager.call(url: "/get-all-my-quests", json: parameters, Completion: {(response) in
            if response != nil {
                self.questArray = [Quest]()
            }
            if let respJSON = response["posted"] as? [Any] {
                print(respJSON)
                guard let jsonArray = respJSON as? [[String: Any]] else {
                      return
                }
                print("##############  posted  #################")
                print(jsonArray)
                self.parseArrayOfQuests(jsonArray: jsonArray, status: "Posted")
            }
            
            if let respJSON = response["taken"] as? [Any] {

                print(respJSON)
                guard let jsonArray = respJSON as? [[String: Any]] else {
                      return
                }
                print("##############  taken #################")
                print(jsonArray)
                self.parseArrayOfQuests(jsonArray: jsonArray, status: "Taken")
            }
            
            if let respJSON = response["proposed"] as? [Any] {
                print(respJSON)
                guard let jsonArray = respJSON as? [[String: Any]] else {
                      return
                }
                print("############    prposed   ###################")
                print(jsonArray)
                self.parseArrayOfQuests(jsonArray: jsonArray, status: "Proposed")
            }
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                ProgressHUD.dismiss()
            }
        })
    }

    func parseArrayOfQuests(jsonArray: [[String: Any]], status: String) {
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
            quest.status = status
            quest.title = dic["title"] as? String
            quest.updatedDate = dic["updatedDate"] as? String
            
            self.questArray.append(quest)
        }
    }
    

}
