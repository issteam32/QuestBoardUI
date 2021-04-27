//
//  HomeViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 22/4/21.
//

import UIKit

class HomeViewController: UITableViewController {

    
    var questArray:[Quest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkManager.isInitialised {
            self.tabBarController?.selectedIndex = 4;
        }
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
    
    func loadQuest()
    {
        
    }
    
    
    func showQuestView(_ item: Quest)
    {
        
        //to push view without defining segueway
        let questVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "questDetails") as! QuestDetailsViewController
        
        questVC.quest = item
        self.navigationController?.pushViewController(questVC, animated: true)
    }
    


}
