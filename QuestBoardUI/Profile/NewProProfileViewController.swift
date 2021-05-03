//
//  NewProProfileViewController.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 3/5/21.
//

import Foundation
import UIKit
import ProgressHUD

class NewProProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var skillsPicker: UIPickerView!
    @IBOutlet weak var skillDescLabel: UILabel!
    @IBOutlet weak var tbSkillDesc: UITextView!
    @IBOutlet weak var saveNewSkillBtn: UIButton!
    
    var skillPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.skillsPicker.dataSource = self
        self.skillsPicker.delegate = self
        self.pageInitData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skillPickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return skillPickerData[row]
    }
    
    @IBAction func saveNewSkill(_ sender: Any) {
        newSkill()
    }
    
    @IBAction func exitSaveNewSkill(_ sender: Any) {
        self.navigateToProfile()
    }
    
    func pageInitData() {
        ProgressHUD.show()
        let parameters: [String : Any] = ["":""]
        
        NetworkManager.call(url: "/get-list-of-skills", json: parameters, Completion: { (response) in
            print(response)
            
            let skills: [String] = response["skills"] as! [String]
            print(skills)
            for value in skills {
                self.skillPickerData.append(value as String)
            }
            DispatchQueue.main.async {
                self.skillsPicker.reloadAllComponents()
            }
            ProgressHUD.dismiss()
        })
        
    }
    
    func newSkill() {
        ProgressHUD.show()
        var skill = skillPickerData[skillsPicker.selectedRow(inComponent: 0)]
        var skillDesc = tbSkillDesc.text.count > 0 ? tbSkillDesc.text! : ""
        
        let json: [String: String] = ["skill": skill, "skillDesc": skillDesc]
        NetworkManager.call(url: "/create-user-skillset-profile", json: json, Completion: {(response) in
            print("saved")
            print(response)
            MyProfileManager.initMyProfileManager()            
            ProgressHUD.dismiss()
        })
    }
    
    func navigateToProfile() {
        if !MyProfileManager.profileIsInitialised {
            MyProfileManager.initMyProfileManager()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
