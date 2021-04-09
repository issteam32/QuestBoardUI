//
//  LoginViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 3/4/21.
//

import UIKit

class LoginViewController: UIViewController{


    
    @IBOutlet weak var tbUserName: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var lbErrorMessage: UILabel!
    var loginToken = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if(tbUserName.text == "" || tbPassword.text == "")
        {
            lbErrorMessage.text = "User name or password is empty"
        }
        
        else{
            
            //loginToken = webservicecall
            //var userID = webservcall
            loginToken = true
            
            if(loginToken == true)
            {
                self.tabBarController?.selectedIndex = 0;
                
            }
        
        }
    }
    
}
