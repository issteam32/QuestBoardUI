//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by Yong Jia on 20/4/21.
//

import Foundation
import UIKit
import WebKit

class ChatViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webWindow: WKWebView!
    
    var chatToken = ChatToken()
    
    var token: String = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTkyMTg1NjQsImlhdCI6MTYxOTE4OTc2NCwianRpIjoiNjMxYzIwNzktZTQ0MS00NWFmLTlkNjYtNzRiMjJjZGMwZTI1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiZTRmMGNjNGItNzcyMS00ZDNhLThjMTItMTc3NjJiMTc1ZTM5IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.QXITtyBhe2ShQOW7V1rIzYTyeRlbz_2iitdOzO9Uadii1qbTKX120Usjh8O2UqFbf36iHjK5YtBAOAkPDPLmg0VVtG0qDBLe3tw0d4NxX2r-yepzXfw2TFU__Bq8024iBcH2yKspdrfIfgCUYRFp9rOnB4Hj1cm9VYvFkllG9qJbhcNURxanvtR_YhQykz9XcmIpaOL9NxueuiqxqPd0gjz-_qNtwJNUgAO1bFOiY85N3pposaDWThjEte9RwpaHROoLfH3mz_eqo9ZKa3-YSQoRmO4zZgvBWO9ulhjkRNlv6gG0VATXrpmnPLgdDrL9PBpppwaFf2igyJ2SjQuyAw"
    var username: String = "yongjia"
    var recipient: String = "user2"
    var questId: String = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        webWindow.uiDelegate = self
        webWindow.navigationDelegate = self
        
        let cssPath = Bundle.main.path(forResource: "bundle", ofType: "css", inDirectory: "www")
        let bundleCss = try! String(contentsOfFile: cssPath!, encoding: String.Encoding.utf8)
        print("the css")
        print(bundleCss)
        
        let cssPath2 = Bundle.main.path(forResource: "global", ofType: "css", inDirectory: "www")
        let globalCss = try! String(contentsOfFile: cssPath2!, encoding: String.Encoding.utf8)
        print("the css")
        print(globalCss)

        
        let jsPath = Bundle.main.path(forResource: "bundle", ofType: "js", inDirectory: "www")
        let js = try! String(contentsOfFile: jsPath!, encoding: String.Encoding.utf8)
        print("the js")
        print(js)
        
        let ChatRoomVC = ChatRoomViewController()
        self.token = ChatRoomVC.token
        
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
        
//        let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www") // file path for file "data.txt"
//        let html = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
//        print("the html")
//        print(html)
//
        
//        concatHtml = "<html> <head><style>\(css)</style> \(html) <script type='text/javascript'> \(js) </script> </body> </html>"

        webWindow.loadHTMLString(fullhtml, baseURL: Bundle.main.resourceURL)

    }
    
}
