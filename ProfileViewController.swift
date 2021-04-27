//
//  ProfileViewController.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 27/4/21.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var everydayProfileTitle: UILabel!
    @IBOutlet weak var everydayProfileLevel: UILabel!
    @IBOutlet weak var autoAssignSwitch: UISwitch!
    @IBOutlet weak var everydayProfleExpBar: UIProgressView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if MyProfileManager.profileIsInitialised {
            pageInitData()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkManager.isInitialised {
            self.navigateToLogin()
        } else {
            if !MyProfileManager.profileIsInitialised {
                MyProfileManager.initMyProfileManager()
            } else {
                pageInitData()
            }
        }
    }
    
    @IBAction func navigateToProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.navigationController?.tabBarController?.selectedIndex = 0
        })
    }
    
    func pageInitData() {
        username.text = MyProfileManager.myProfile?.userName
        email.text = MyProfileManager.myProfile?.email
        everydayProfileTitle.text = MyProfileManager.everydayProfile?.title
        everydayProfileLevel.text = "\(MyProfileManager.everydayProfile!.level!)"
        everydayProfleExpBar.setProgress(Float(MyProfileManager.everydayProfile!.exp!), animated: true)
    }
    
    func navigateToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginView" ) as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
    }

}


extension ProfileViewController: LoginViewControllerDelegate {
    func loginControllerWillDisapear(_ modal: LoginViewController) {
        // This is called when your modal will disappear. You can reload your data.
        print("reload")
        self.pageInitData()
    }
}
