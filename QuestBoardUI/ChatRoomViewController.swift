//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by Yong Jia on 22/4/21.
//

import Foundation
import UIKit

struct ChatRoom {
    var questName: String
    var recipientName: String
}

struct Chat: Decodable {
    var chatId: String?
    var id: String
    var questId: String?
    var questName: String?
    var recipientId: String?
    var senderId: String?
}

class ChatRoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var questName: UILabel!
    
}

class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tokenType: String = "Bearer"
    var token: String = ""
    var chats = [Chat]()
    var chatToken = ChatToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkManager.isInitialised {
            self.tabBarController?.selectedIndex = 4;
        } else {
            getChatRooms()
        }
    }
    
    func getChatRooms() {
        self.token = NetworkManager.nToken
        self.chats = [Chat]()
        
        print("is init?? \(NetworkManager.isInitialised)")
        
        let headers = [
          "Content-Type": "application/json",
            "Authorization": "\(self.tokenType) \(self.token)"
        ]
        let parameters = ["type": "requestor"] as [String : Any]

        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: URL(string: "https://questboard-api-gateway-pllorhkrga-as.a.run.app/api/chat-rooms")!,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    for (key, value) in json {
                        if key == "chatRooms" {
                            if let arrObj = value as? [Any] {
                                for value2 in arrObj {
                                    if let dict = value2 as? [String: Any] {
                                        self.chats.append(Chat(
                                           chatId: dict["chatId"] as? String,
                                           id: dict["id"] as! String,
                                           questId: dict["questId"] as? String,
                                           questName: dict["questName"] as? String,
                                           recipientId: dict["recipientId"] as? String,
                                           senderId: dict["senderId"] as? String
                                       ))
                                    }
                                }
                            } else {
                                print("convert to chat failed")
                            }
                        }
                    }
                    print(self.chats)
                } else {
                    print("convert failed")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })

        task.resume()
    }
}

extension ChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
        //to push view without defining segueway
        
        chatToken.questId = chats[indexPath.row].questId
        chatToken.chatId = chats[indexPath.row].chatId
        chatToken.id = chats[indexPath.row].id
        chatToken.questName = chats[indexPath.row].questName
        chatToken.recipientId = chats[indexPath.row].senderId
        chatToken.senderId = chats[indexPath.row].recipientId
        chatToken.token = token
                
        //performSegue(withIdentifier: "chatRoomToChat", sender: chats[indexPath.row])
        
        print(chatToken.questId!)
        print(chatToken.chatId!)
        print(chatToken.senderId!)
        print(chatToken.recipientId!)
        print("---------------------")
        let chatVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "newChat") as! ChatViewController
        chatVC.chatToken = self.chatToken
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoomCell", for: indexPath) as! ChatRoomTableViewCell
        
        print(chats)
        let chatRoom = chats[indexPath.row]
        
        cell.questName?.text = (chatRoom.questName == "") ? "No quest title" : chatRoom.questName
        cell.recipientName?.text = chatRoom.senderId
                
        return cell
    }
}
