//
//  ItemsTableViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 8/4/21.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    
    var category: Category?
    var questArray: [Quest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        self.title = category?.name
        print("selected cat \(String(describing: category?.name))")
//        if category != nil
//        {
//            loadQuest()
//        }
        
        loadQuest()
        
        }

    // MARK: - Table view data source

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        print(questArray.count)
        return questArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuestTableViewCell
        
        cell.generateCell(questArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showQuestView(questArray[indexPath.row])
    }
    
    func showQuestView(_ item: Quest)
    {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "questDetails") as! QuestDetailsViewController
        
        questVC.quest = item
        questVC.isNew = true
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    
    func loadQuest()
    {
        let quest1 = Quest()
        quest1.id = 1
        quest1.title = "Quest1"
        quest1.category = 3
        quest1.description = "This is the description for quest. Some help needed for XXXXXX location is at XXXXX"
        quest1.reward = "3000"
        quest1.location = "Some where in yishun"
        quest1.skillRequired = "Nil"

        
        let quest2 = Quest()
        quest2.id = 2
        quest2.title = "Quest2"
        quest1.category = 3
        quest2.description = "This is the description for quest2. Some help needed for XXXXXX location is at XXXXX"
        quest2.reward = "5000"
        quest2.location = "Some where in Serangoon"
        quest2.skillRequired = "Able to stand very long"
        
        
        let quest3 = Quest()
        quest3.id = 3
        quest3.title = "Quest3"
        quest1.category = 3
        quest3.description = "This is the description for quest3. Some help needed for XXXXXX location is at XXXXX"
        quest3.reward = "1000"
        quest3.location = "Some where in Bishan"
        quest3.skillRequired = "Able to run"
        
        
        questArray.append(quest1)
        questArray.append(quest2)
        questArray.append(quest3)
    }

}
