//
//  ChatViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 18/3/21.
//

import UIKit
import MessageKit
import Starscream
import InputBarAccessoryView

struct Sender: SenderType
{
    var senderId: String
    var displayName: String
}


struct Message:MessageType
{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    
}

class ChatViewController: MessagesViewController , MessagesDataSource , MessagesLayoutDelegate , MessagesDisplayDelegate , WebSocketDelegate, InputBarAccessoryViewDelegate {
    
    
    
    
    
  
    let currentUser = Sender(senderId: "self", displayName: "IOs")
    let otherUser = Sender(senderId: "other", displayName: "ios other")
    var message = [MessageType]()
    
    
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "ws://localhost:8080/chat")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
        message.append(Message(
            sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-70000), kind: .text("testing from main")
        ))
        
        
        message.append(Message(
            sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-60000), kind: .text("reply from other")
        ))
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
           switch event {
           case .connected(let headers):
               isConnected = true
               print("websocket is connected: \(headers)")
           case .disconnected(let reason, let code):
               isConnected = false
               print("websocket is disconnected: \(reason) with code: \(code)")
           case .text(let string):
               print("Received text: \(string)")
            receiveMessage(textString: string)
           case .binary(let data):
               print("Received data: \(data.count)")
           case .ping(_):
               break
           case .pong(_):
               break
           case .viabilityChanged(_):
               break
           case .reconnectSuggested(_):
               break
           case .cancelled:
               isConnected = false
           case .error(let error):
               isConnected = false
               handleError(error)
           }
       }
    
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return message[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return message.count
    }
    

    func sendMessage(_ newMessage:Message)
    {
        message.append(newMessage)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }

    }
    
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = Message(
            sender: currentUser, messageId: "2", sentDate: Date().addingTimeInterval(-60000), kind: .text(text))
        //calling function to insert and save message

        
//        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName!)
//        //calling function to insert and save message
        
        
        sendMessage(message)
        socket.write(string: text)
    }

    
    func receiveMessage(textString : String)
    {
        
        message.append(Message(
            sender: otherUser, messageId: "1", sentDate: Date().addingTimeInterval(-70000), kind: .text(textString)
        ))
        messagesCollectionView.reloadData()
        
    }

}
