//
//  ViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 7/3/21.
//

import UIKit
import Starscream


class ViewController: UIViewController , WebSocketDelegate{

    
    @IBOutlet weak var btnConnect: UIButton!
    
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
      }
      
      // MARK: - WebSocketDelegate
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
      
      // MARK: Write Text Action

    @IBAction func btnCon(_ sender: UIButton) {
        if isConnected {
                   socket.disconnect()
            } else {
                socket.connect()
            }
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        socket.write(string: "hello there!")
    }
    
}

