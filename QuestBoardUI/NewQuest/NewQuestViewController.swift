//
//  NewQuestViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 9/4/21.
//

import UIKit

class NewQuestViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{

    typealias JSONDictionary = [String : Any]
    
    var quest = Quest()
    var category:Category!
 
    @IBOutlet weak var questNameErrMsg: UILabel!
    @IBOutlet weak var questCategory: UIPickerView!
    @IBOutlet weak var questDescriptionErrMsg: UILabel!
    @IBOutlet weak var questCategoryErrMsg: UILabel!
    @IBOutlet weak var QuestLocationErrMsg: UILabel!
    
    @IBOutlet weak var tbQuestName: UITextField!
    @IBOutlet weak var tbQuestReward: UITextField!
    @IBOutlet weak var tbQuestLocation: UITextView!
    @IBOutlet weak var tvQuestDesc: UITextView!
    @IBOutlet weak var btnCreateQuest: UIButton!
    @IBOutlet weak var switchCategory: UISwitch!
    
    @IBOutlet weak var skillNeddedLabel: UILabel!
    var skillPickerData: [String] = [String]()
    @IBOutlet weak var skillPicker: UIPickerView!
    @IBOutlet weak var skillPickerView: UIView!
    
    var pickerData: [String] = [String]()
    @IBOutlet weak var scrollView: UIScrollView!
    

    @IBOutlet weak var constConcernLabel: UILabel!
    @IBOutlet weak var tbCostConcern: UITextField!
    @IBOutlet weak var timingConcernLabel: UILabel!
    @IBOutlet weak var timingConcernDatePicker: UIDatePicker!
    
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
        self.quest = Quest()
        viewInit()
        self.showToast(message: "Exit new quest")
        self.tabBarController?.selectedIndex = 0
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.switchCategory.addTarget(self, action: #selector(switchCategoryChanged), for: .valueChanged)
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        self.tvQuestDesc.layer.borderColor = borderColor.cgColor
        self.tvQuestDesc.layer.borderWidth = 0.5
        self.tvQuestDesc.layer.cornerRadius = 5.0
        
        self.tbQuestLocation.layer.borderColor = borderColor.cgColor
        self.tbQuestLocation.layer.borderWidth = 0.5
        self.tbQuestLocation.layer.cornerRadius = 5.0
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkManager.isInitialised {
            self.tabBarController?.selectedIndex = 4;
        } else {
            scrollView.contentSize = CGSize(width: 414, height: 1325)
            viewInit()
            pageInitData()
        }
    }
    
    
    @IBAction func submitCreateQuest(_ sender: UIButton) {
        createQuest()
//        createQuestConcern(id: 1)
    }
    
    @IBAction func switchCategoryChanged(_ sender: UISwitch) {
        if switchCategory.isOn {
            print("professional category selected")
            self.quest.category = 1
            self.skillPickerView.isHidden = false
            self.tbCostConcern.isHidden = false
            self.timingConcernDatePicker.isHidden = false
            self.tbCostConcern.isEnabled = true
            self.tbCostConcern.isUserInteractionEnabled = true
            self.constConcernLabel.isHidden = false
            self.timingConcernLabel.isHidden = false
        } else {
            print("everyday category selected")
            self.quest.category = 0
            self.skillPickerView.isHidden = true
            self.tbCostConcern.isHidden = true
            self.timingConcernDatePicker.isHidden = true
            self.constConcernLabel.isHidden = true
            self.timingConcernLabel.isHidden = true
        }
    }
    
    func viewInit() {
        pickerData = ["Walk the Dog" , "Let\'s Dabao" , "Fix me" , "Get queueing"]
        self.questCategory.dataSource = self
        self.questCategory.delegate = self
        
        self.skillPicker.dataSource = self
        self.skillPicker.delegate = self
        
        self.skillPickerView.isHidden = true
        
        self.tbCostConcern.isHidden = true
        self.timingConcernDatePicker.isHidden = true
        
        self.constConcernLabel.isHidden = true
        self.timingConcernLabel.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if questCategory == pickerView {
            return pickerData.count
        } else if skillPicker == pickerView {
            return skillPickerData.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if questCategory == pickerView {
            return pickerData[row]
        } else if skillPicker == pickerView {
            return skillPickerData[row]
        } else {
            return ""
        }
    }
    
    func createQuest()
    {
        self.quest.categoryDesc = pickerData[questCategory.selectedRow(inComponent: 0)]
        self.quest.description = tvQuestDesc.text
        self.quest.location = tbQuestLocation.text
        self.quest.reward = tbQuestReward.text
        self.quest.category = (switchCategory.isOn) ? 1 : 0
        self.quest.skillRequired = (switchCategory.isOn && skillPickerData.count > 0) ? skillPickerData[skillPicker.selectedRow(inComponent: 0)] : ""
        self.quest.requestor = MyProfileManager.myProfile?.userName!
        self.quest.title = tbQuestName.text
        self.quest.printMyself()
        
//        let headers = [
//          "Content-Type": "application/json",
//          "Authorization": "Bearer \(tmpToken)"
//        ]
        
        let json: [String: Any] = ["title": self.quest.title!,
                                   "requestor": self.quest.requestor!,
                                   "location": self.quest.location!,
                                   "description": self.quest.description!,
                                   "category": self.quest.category,
                                   "skillRequired": (switchCategory.isOn) ? self.quest.skillRequired! : "",
                                   "rewardType": self.quest.rewardType!,
                                   "reward": self.quest.reward!,
                                   "categoryDesc": self.quest.categoryDesc!]

        NetworkManager.call(url: "/create-quest", json: json, Completion: { (responseJSON) in
            if self.quest.category == 1 {
                if let id = responseJSON["id"] as? Int {
                    self.createQuestConcern(id: id)
                    self.showToast(message: "Your quest is posted successfully")
                } else {
                    self.showToast(message: "Concerns is not created")
                }
            } else {
                self.showToast(message: "Your quest is posted successfully")
                DispatchQueue.main.async {
                    self.pageInitData()
                }
            }
        })
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        let url = URL(string: "\(apiPath)/create-quest")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            do {
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let responseJSON = responseJSON as? [String: Any] {
//                    print(responseJSON)
//                    if self.quest.category == 1 {
//                        if let id = responseJSON["id"] as? Int {
//                            self.createQuestConcern(id: id)
//                            self.showToast(message: "Your quest is posted successfully")
//                        } else {
//                            self.showToast(message: "Concerns is not created")
//                        }
//                    } else {
//                        self.showToast(message: "Your quest is posted successfully")
//                        self.tabBarController?.selectedIndex = 0
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
    }

    func createQuestConcern(id: Int) {
//        let headers = [
//          "Content-Type": "application/json",
//          "Authorization": "Bearer \(tmpToken)"
//        ]
        
        var json: [String: Any] = [String: Any]()
        if tbCostConcern.isHidden == false {
            if tbCostConcern.text != "" {
                let validationJSON: String = "{\"concern\":\"money\",\"operator\":\">\",\"evaluation\":\"\(tbCostConcern.text!)\"}"
                json["cost"] = ["context": "money", "concernValidation": validationJSON , "questId": id]
            }
        }
        
        if timingConcernDatePicker.isHidden == false {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let validationJSON: String = "{\"concern\":\"time\",\"operator\":\">\",\"evaluation\":\"\(dateFormatter.string(from: timingConcernDatePicker.date))\"}"
            json["time"] = ["context": "time", "concernValidation": validationJSON, "questId": id]
        }
        
        NetworkManager.call(url: "/create-quest-user-concernss", json: json, Completion: { (response) in
            self.showToast(message: "Concerns is created")
        })
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        // let localhost = "http://127.0.0.1:8080/api"
//        let url = URL(string: "\(apiPath)/create-quest-user-concernss")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            do {
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let responseJSON = responseJSON as? [String: Any] {
//                    print(responseJSON)
//                    self.showToast(message: "Concerns is created")
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
    }
    
    func pageInitData() {
        let parameters: [String : Any] = ["":""]
        
        NetworkManager.call(url: "/get-list-of-skills", json: parameters, Completion: { (response) in
            print(response)
            
            let skills: [String] = response["skills"] as! [String]
            print(skills)
            for value in skills {
                self.skillPickerData.append(value as String)
            }
            DispatchQueue.main.async {
                self.skillPicker.reloadAllComponents()
            }
        })
        
    }
    
}

extension UIViewController {

func showToast(message : String) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-200, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = .systemFont(ofSize: 15.0)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    DispatchQueue.main.async {
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
} }
