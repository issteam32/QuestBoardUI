//
//  LoginViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 3/4/21.
//
import ProgressHUD
import UIKit

class LoginViewController: UIViewController{


    weak var delegate: LoginViewControllerDelegate?
    @IBOutlet weak var tbUserName: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var lbErrorMessage: UILabel!
    var loginToken = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NetworkManager.isInitialised {
            self.navigateToProfile()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.loginControllerWillDisapear(self)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        ProgressHUD.show()
        if(tbUserName.text == "" || tbPassword.text == "")
        {
            lbErrorMessage.text = "User name or password is empty"
        }
        else{
            
            let headers = [
              "Content-Type": "application/json"
            ]
            
            let json: [String: String] = ["username": tbUserName.text!,"password": tbPassword.text!]

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            let url = URL(string: "\(apiPath)/login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                        
                        if let token = responseJSON["access_token"] as? String {
                            NetworkManager.isInitialised = true
                            NetworkManager.initToken(token: token as! String)
                        
                            self.loginToken = true
                            
                            if(self.loginToken == true)
                            {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                                    ProgressHUD.dismiss()
                                    self.navigateToProfile()
                                })
                            }
                        } else {
                            ProgressHUD.colorBackground = .systemRed                        
                            ProgressHUD.showFailed()
                        }
                    }
                } catch let error {
                    ProgressHUD.dismiss()
                    print(error.localizedDescription)
                }
            }

            task.resume()                    
        }
    }
    
    func navigateToProfile() {
        if !MyProfileManager.profileIsInitialised {
            MyProfileManager.initMyProfileManager()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
