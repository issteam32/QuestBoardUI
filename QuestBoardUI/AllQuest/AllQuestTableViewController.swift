//
//  AllQuestTableViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 26/4/21.
//

import UIKit

class AllQuestTableViewController: UITableViewController {

    
    var questArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuest()
        tableView.tableFooterView = UIView()
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
        showQuestView(questArray[indexPath.row])
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func showQuestView(_ item: Item)
    {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "questDetails") as! QuestDetailsViewController
        
        questVC.quest = item
        questVC.isNew = false
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    
    func loadQuest()
    {
        let quest1 = Item()
        quest1.id = "5"
        quest1.name = "Quest5"
        quest1.categoryId = "5"
        quest1.description = "This is the description for quest5. Some help needed for XXXXXX location is at XXXXX"
        quest1.reward = "3000"
        quest1.location = "Some where in yishun"
        quest1.skillRequired = "Nil"
        quest1.status = "Posted"

        
        let quest2 = Item()
        quest2.id = "6"
        quest2.name = "Quest6"
        quest2.categoryId = "6"
        quest2.description = "This is the description for quest6. Some help needed for XXXXXX location is at XXXXX"
        quest2.reward = "5000"
        quest2.location = "Some where in Serangoon"
        quest2.skillRequired = "Able to stand very long"
        quest2.status = "Posted"
        
        
        let quest3 = Item()
        quest3.id = "7"
        quest3.name = "Quest7"
        quest3.categoryId = "7"
        quest3.description = "This is the description for quest7. Some help needed for XXXXXX location is at XXXXX"
        quest3.reward = "1000"
        quest3.location = "Some where in Bishan"
        quest3.skillRequired = "Able to run"
        quest3.status = "Taken"
        
        
        questArray.append(quest1)
        questArray.append(quest2)
        questArray.append(quest3)
    }

}
