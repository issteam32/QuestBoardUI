//
//  NewQuestProposalViewController.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 27/4/21.
//

import Foundation
import UIKit

class NewQuestProposalViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var proposalLabel: UILabel!
    @IBOutlet weak var tvProposalDetail: UITextView!
    @IBOutlet weak var estimatedCostLabel: UILabel!
    @IBOutlet weak var tbEstimatedCost: UITextField!
    @IBOutlet weak var estimatedCompleteLabel: UILabel!
    @IBOutlet weak var estimatedCompletionDatePicker: UIDatePicker!
    @IBOutlet weak var sendProposalBtn: UIButton!
    
    let questId: Int = 1
    let username: String = "yongjia"
    
    var moneyAnswerJsonTemp = "{\"concern\":\"money\",\"operator\":\"<\",\"evaluation\":\"#?\"}"
    var timeAnswerJsonTemp = "{\"concern\":\"time\",\"operator\":\"<\",\"evaluation\":\"#?\"}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        viewInit()
    }
    
    func viewInit(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.showToast(message: "View inited")
    }
        
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
   
    @IBAction func sendProposal(_ sender: Any) {
        createProposal()
    }
    
    func createProposal() {
        let proposalDetails = tvProposalDetail.text!
        let estimatedCost = tbEstimatedCost.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let estimatedDate = dateFormatter.string(from: estimatedCompletionDatePicker.date)
        
        let moneyAnswerJson = moneyAnswerJsonTemp.replacingOccurrences(of: "#?", with: estimatedCost)
        let timeAnswerJson = timeAnswerJsonTemp.replacingOccurrences(of: "#?", with: estimatedDate)
        
        let headers = [
          "Content-Type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzcU5VcEZwcmZHU1BIVWF6YU5jQ3NoX2U1bmhrMTNmS1J3OGxiNzk1QlRBIn0.eyJleHAiOjE2MTk0NTg2NTAsImlhdCI6MTYxOTQyOTg1MCwianRpIjoiMmEyYTg1NzMtN2NkZS00OWE0LTk0OTktYjE4ZDg1OTZhYjA1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnF1ZXN0c2JvdC54eXovYXV0aC9yZWFsbXMvUXVlc3Rib2FyZCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJjNzA5NTg2MC00MjFlLTQ4ZGYtYWFkYy04ZTM0OTcwYWUyYjIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJxdWVzdGJvYXJkLW1vYmlsZS1jbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiYjkyODZhYjktNGNiYi00ZmM5LWEzYzItNzU5OWUxMTc1MDA2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovLzM1LjE5Ny4xNDYuMjIxIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoieW9uZ2ppYSBjaGFuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoieW9uZ2ppYSIsImdpdmVuX25hbWUiOiJ5b25namlhIiwiZmFtaWx5X25hbWUiOiJjaGFuIiwiZW1haWwiOiJ5b25namlhQGVtYWlsLmNvbSJ9.XziMIJAHZgUyYFBCtKBJ3k7CSkuC8RWiY-SxSxESphDnXD9O6Z1n4It1lIfWwXgG4A6jO_FZp_EG0ZQxxH-QlvPM0lQn-kBrCmvb-sirgM1CMSkQg58N2mE84gJhs0qlbLDI1fTmKU2mkV9LfPPdYNPmpnUL0D8a16681CCUrHXR8nS8qhLYmMlk7c7cIbkcyXw19guqDMkUOJTtOUJ5IlVHZMjPwwzE0ilbWgFgqbB394Lcu4ok7LQX6ip3ymdfBh-1z-hZx9quJZhORVcDlLhNEG_me45afYtvOZAyjBTrY3X1XJpRXO-5hDufifqpoHhggOLaVrm91qwFGxmSHA"
        ]
        
        var json: [String: Any] = [String: Any]()
        
        var answersJson: [String] = [String]()
        if estimatedCost != "" {
            answersJson.append(moneyAnswerJson)
        }
        
        if estimatedDate != "" {
            answersJson.append(timeAnswerJson)
        }
        
        let concernAnswered: [String: Any] = ["version": 1, "concernAnswered": answersJson, "proposalDetail":""]
        json["proposalDetails"] = proposalDetails
        json["proposalJson"] = concernAnswered
        json["questId"] = self.questId
        json["username"] = self.username
        
        print(json)
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        // let localhost = "http://127.0.0.1:8080/api"
//        let url = URL(string: "\(apiPath)/create-quest-proposal")!
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
}
