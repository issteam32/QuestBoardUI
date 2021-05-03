//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by Yong Jia on 20/4/21.
//

import Foundation
import UIKit
import WebKit
import ProgressHUD

class ChatViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webWindow: WKWebView!
    
    var chatToken = ChatToken()
    var token: String = ""
    var username: String = "yongjia"
    var recipient: String = "user2"
    var questId: String = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
                
        webWindow.uiDelegate = self
        webWindow.navigationDelegate = self
        
        let cssPath = Bundle.main.path(forResource: "bundle", ofType: "css", inDirectory: "www")
        let bundleCss = try! String(contentsOfFile: cssPath!, encoding: String.Encoding.utf8)
//        print("the css")
//        print(bundleCss)
        
        let cssPath2 = Bundle.main.path(forResource: "global", ofType: "css", inDirectory: "www")
        let globalCss = try! String(contentsOfFile: cssPath2!, encoding: String.Encoding.utf8)
//        print("the css")
//        print(globalCss)

        
        let jsPath = Bundle.main.path(forResource: "bundle", ofType: "js", inDirectory: "www")
        let js = try! String(contentsOfFile: jsPath!, encoding: String.Encoding.utf8)
//        print("the js")
//        print(js)
                
        chatToken.token = NetworkManager.nToken
        chatToken.senderId = MyProfileManager.myProfile?.userName        
        
        print("senderId: \(chatToken.senderId!)")
        print("recipientId: \(chatToken.recipientId!)")
        print("questId: \(chatToken.questId!)")
        print("questId: \(chatToken.questId!)")
        
        let fullhtml: String = "<!DOCTYPE html><html lang='en'>" +
            "<head><meta charset='utf-8'>" +
            "<meta name='viewport' content='width=device-width,initial-scale=1'>" +
            "<style>\(bundleCss)</style>" +
            "<style>\(globalCss)</style>" +
            "</head>" +
            "<body>" +
            "<input id='username' name='username' type='hidden' value='\(chatToken.senderId!)' />" +
            "<input id='recipient' name='recipient' type='hidden' value='\(chatToken.recipientId!)' />" +
            "<input id='questid' name='questid' type='hidden' value='\(chatToken.questId!)' />" +
            "<input id='token' name='token' type='hidden' value='\(chatToken.token!)'/>" +
            "<script>\(js)</script>" +
            "</body>" +
            "</html>"

        webWindow.loadHTMLString(fullhtml, baseURL: Bundle.main.resourceURL)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            ProgressHUD.dismiss()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !NetworkManager.isInitialised {
            self.tabBarController?.selectedIndex = 4;
        }
    }
}
