//
//  NewQuestViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 9/4/21.
//

import UIKit

class NewQuestViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{

    typealias JSONDictionary = [String : Any]
    
    let quest = Quest()
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
        print("hahahah")
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
        
        scrollView.contentSize = CGSize(width: 414, height: 1325)
        
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
        pageInitData()
    }
    
    @IBAction func submitCreateQuest(_ sender: UIButton) {
//        createQuest()
        createQuestConcern(id: 1)
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
        self.quest.category = 0
        self.quest.categoryDesc = pickerData[questCategory.selectedRow(inComponent: 0)]
        self.quest.description = tvQuestDesc.text
        self.quest.location = tbQuestLocation.text
        self.quest.reward = tbQuestReward.text
        self.quest.category = (switchCategory.isOn) ? 1 : 0
        self.quest.skillRequired = (skillPickerData.count > 0) ? skillPickerData[skillPicker.selectedRow(inComponent: 0)] : ""
        self.quest.printMyself()
        self.quest.requestor = "yongjia"
        let headers = [
          "Content-Type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTk0NTg2NTAsImlhdCI6MTYxOTQyOTg1MCwianRpIjoiMmEyYTg1NzMtN2NkZS00OWE0LTk0OTktYjE4ZDg1OTZhYjA1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiYjkyODZhYjktNGNiYi00ZmM5LWEzYzItNzU5OWUxMTc1MDA2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.XziMIJAHZgUyYFBCtKBJ3k7CSkuC8RWiY-SxSxESphDnXD9O6Z1n4It1lIfWwXgG4A6jO_FZp_EG0ZQxxH-QlvPM0lQn-kBrCmvb-sirgM1CMSkQg58N2mE84gJhs0qlbLDI1fTmKU2mkV9LfPPdYNPmpnUL0D8a16681CCUrHXR8nS8qhLYmMlk7c7cIbkcyXw19guqDMkUOJTtOUJ5IlVHZMjPwwzE0ilbWgFgqbB394Lcu4ok7LQX6ip3ymdfBh-1z-hZx9quJZhORVcDlLhNEG_me45afYtvOZAyjBTrY3X1XJpRXO-5hDufifqpoHhggOLaVrm91qwFGxmSHA"
        ]
        
        let json: [String: Any] = ["title": self.quest.title!,
                                   "requestor": self.quest.requestor!,
                                   "location": self.quest.location!,
                                   "description": self.quest.description!,
                                   "category": self.quest.category,
                                   "skillRequired": self.quest.skillRequired!,
                                   "rewardType": self.quest.rewardType!,
                                   "reward": self.quest.reward!]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "\(apiPath)/create-quest")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        // insert json data to the request
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
                    if let id = responseJSON["id"] as? Int {
                        self.createQuestConcern(id: id)
                    } else {
                        // pop up error message
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

    func createQuestConcern(id: Int) {
        let headers = [
          "Content-Type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTk0NTg2NTAsImlhdCI6MTYxOTQyOTg1MCwianRpIjoiMmEyYTg1NzMtN2NkZS00OWE0LTk0OTktYjE4ZDg1OTZhYjA1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiYjkyODZhYjktNGNiYi00ZmM5LWEzYzItNzU5OWUxMTc1MDA2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.XziMIJAHZgUyYFBCtKBJ3k7CSkuC8RWiY-SxSxESphDnXD9O6Z1n4It1lIfWwXgG4A6jO_FZp_EG0ZQxxH-QlvPM0lQn-kBrCmvb-sirgM1CMSkQg58N2mE84gJhs0qlbLDI1fTmKU2mkV9LfPPdYNPmpnUL0D8a16681CCUrHXR8nS8qhLYmMlk7c7cIbkcyXw19guqDMkUOJTtOUJ5IlVHZMjPwwzE0ilbWgFgqbB394Lcu4ok7LQX6ip3ymdfBh-1z-hZx9quJZhORVcDlLhNEG_me45afYtvOZAyjBTrY3X1XJpRXO-5hDufifqpoHhggOLaVrm91qwFGxmSHA"
        ]
        
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
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        // let localhost = "http://127.0.0.1:8080/api"
        let url = URL(string: "\(apiPath)/create-quest-user-concernss")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        // insert json data to the request
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
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }

        task.resume()
//        print(jsonData?.base64EncodedString())
    }
    
    func pageInitData() {
        let headers = [
          "Content-Type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTk0NTg2NTAsImlhdCI6MTYxOTQyOTg1MCwianRpIjoiMmEyYTg1NzMtN2NkZS00OWE0LTk0OTktYjE4ZDg1OTZhYjA1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiYjkyODZhYjktNGNiYi00ZmM5LWEzYzItNzU5OWUxMTc1MDA2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.XziMIJAHZgUyYFBCtKBJ3k7CSkuC8RWiY-SxSxESphDnXD9O6Z1n4It1lIfWwXgG4A6jO_FZp_EG0ZQxxH-QlvPM0lQn-kBrCmvb-sirgM1CMSkQg58N2mE84gJhs0qlbLDI1fTmKU2mkV9LfPPdYNPmpnUL0D8a16681CCUrHXR8nS8qhLYmMlk7c7cIbkcyXw19guqDMkUOJTtOUJ5IlVHZMjPwwzE0ilbWgFgqbB394Lcu4ok7LQX6ip3ymdfBh-1z-hZx9quJZhORVcDlLhNEG_me45afYtvOZAyjBTrY3X1XJpRXO-5hDufifqpoHhggOLaVrm91qwFGxmSHA"
        ]
        let parameters: [String : Any] = ["":""]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "\(apiPath)/get-list-of-skills")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: [String]] {
                    let skills: [String] = json["skills"]!
                    print(skills)
                    for value in skills {
                        self.skillPickerData.append(value as String)
                    }
                    DispatchQueue.main.async {
                        self.skillPicker.reloadAllComponents()
                    }
                } else {
                    print("convert failed")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        dataTask.resume()
    }
    
}
