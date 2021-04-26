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
    var token: String = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTkyMTg1NjQsImlhdCI6MTYxOTE4OTc2NCwianRpIjoiNjMxYzIwNzktZTQ0MS00NWFmLTlkNjYtNzRiMjJjZGMwZTI1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiZTRmMGNjNGItNzcyMS00ZDNhLThjMTItMTc3NjJiMTc1ZTM5IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.QXITtyBhe2ShQOW7V1rIzYTyeRlbz_2iitdOzO9Uadii1qbTKX120Usjh8O2UqFbf36iHjK5YtBAOAkPDPLmg0VVtG0qDBLe3tw0d4NxX2r-yepzXfw2TFU__Bq8024iBcH2yKspdrfIfgCUYRFp9rOnB4Hj1cm9VYvFkllG9qJbhcNURxanvtR_YhQykz9XcmIpaOL9NxueuiqxqPd0gjz-_qNtwJNUgAO1bFOiY85N3pposaDWThjEte9RwpaHROoLfH3mz_eqo9ZKa3-YSQoRmO4zZgvBWO9ulhjkRNlv6gG0VATXrpmnPLgdDrL9PBpppwaFf2igyJ2SjQuyAw"
    var chats = [Chat]()
    var chatToken = ChatToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getChatRooms()
        self.tableView.reloadData()
    }
    
    func getChatRooms() {
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
        chatToken.recipientId = chats[indexPath.row].recipientId
        chatToken.senderId = chats[indexPath.row].senderId
        chatToken.token = token
        
        
        //performSegue(withIdentifier: "chatRoomToChat", sender: chats[indexPath.row])
        
        
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
