//
//  AllProposalTableViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 29/4/21.
//

import UIKit

class AllProposalTableViewController: UITableViewController {
    
    
    var proposalArray: [Proposal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProposal()

    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return proposalArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllProposalTableViewCell
        cell.generateCell(proposalArray[indexPath.row])
        cell.btnChatRef.tag = proposalArray[indexPath.row].id
        cell.btnAcceptRef.tag = proposalArray[indexPath.row].id
        cell.btnChatRef.addTarget(self, action: #selector(btnOnCLick(sender:)), for: .touchUpInside)
        cell.btnAcceptRef.addTarget(self, action: #selector(btnOnCLick(sender:)), for: .touchUpInside)
//        cell.btnChatRef.tag = proposalArray[indexPath.row].id
//        cell.btnAcceptRef.tag = proposalArray[indexPath.row].id
        
        
        
        
        return cell
    }
    
    
    @objc func btnOnCLick(sender: UIButton)
    {
        if(sender.titleLabel!.text == "Chat")
        {
            
            var chatToken = ChatToken()
            chatToken.questId = "1"
            chatToken.chatId = ""
            chatToken.id = ""
            chatToken.questName = ""
            chatToken.recipientId = "yongjia"
            chatToken.senderId = MyProfileManager.myProfile?.userName
            chatToken.token = ""
            
            
            let chatVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "newChat") as! ChatViewController
            chatVC.chatToken = chatToken
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
        else
        {
            
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "proposalDetails") as! ProposalDetailsViewController
            VC.proposalId = sender.tag
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
        
    }
    
    
    func loadProposal()
    {
        let propose1 = Proposal()
        propose1.id = 1
        propose1.senderName = "User10"
        propose1.offer = "$40"
        propose1.lastMessage = "I can do this for $40"
        
        
        let propose2 = Proposal()
        propose2.id = 2
        propose2.senderName = "User15"
        propose2.offer = "$60"
        propose2.lastMessage = "I can do this for $60"
        
        proposalArray.append(propose1)
        proposalArray.append(propose2)
        
    }
    
    
}
