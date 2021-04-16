//
//  NewQuestViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 9/4/21.
//

import UIKit

class NewQuestViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{

    
    var category:Category!
 
    @IBOutlet weak var questNameErrMsg: UILabel!
    @IBOutlet weak var questCategory: UIPickerView!
    @IBOutlet weak var questDescriptionErrMsg: UILabel!
    @IBOutlet weak var questCategoryErrMsg: UILabel!
    @IBOutlet weak var QuestLocationErrMsg: UILabel!
    
    @IBOutlet weak var tbQuestName: UITextField!
    @IBOutlet weak var tbQuestDescription: UITextView!
    @IBOutlet weak var tbQuestReward: UITextField!
    @IBOutlet weak var tbQuestLocation: UITextView!
    
    
    @IBAction func btnDone(_ sender: Any) {
         //Create NS dictionary
        //send as json
        //webservicecall
        
//        questNameErrMsg.isHidden = false
//        questNameErrMsg.text = "Error"
//
//        questDescriptionErrMsg.isHidden = false
//        questDescriptionErrMsg.text = "Error"
//
//        questCategoryErrMsg.isHidden = false
//        questCategoryErrMsg.text = "Error"
//
//        QuestLocationErrMsg.isHidden = false
//        QuestLocationErrMsg.text = "Error"
        print("hahahah")
        self.tabBarController?.selectedIndex = 0
    }
    
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = ["Walk the Dog" , "Let\'s Dabao" , "Fix me" , "Get queueing"]
        self.questCategory.dataSource = self
        self.questCategory.delegate = self

    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func createQuest()
    {
        let item = Item()
        item.categoryId = pickerData[questCategory.selectedRow(inComponent: 0)]
        item.description = tbQuestDescription.text
        item.id = UUID().uuidString
        item.location = tbQuestLocation.text
        item.reward = Double(tbQuestReward.text!)
        
    }

    
}
