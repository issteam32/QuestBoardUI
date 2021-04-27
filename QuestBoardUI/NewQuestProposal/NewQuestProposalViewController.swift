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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !NetworkManager.isInitialised {
            self.tabBarController?.selectedIndex = 4;
        }
    }

        
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
   
    @IBAction func sendProposal(_ sender: Any) {
        self.createProposal()
        self.showToast(message: "test message")
    }
    
    func createProposal() {
        let proposalDetails = tvProposalDetail.text!
        let estimatedCost = tbEstimatedCost.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let estimatedDate = dateFormatter.string(from: estimatedCompletionDatePicker.date)
        
        let moneyAnswerJson = moneyAnswerJsonTemp.replacingOccurrences(of: "#?", with: estimatedCost)
        let timeAnswerJson = timeAnswerJsonTemp.replacingOccurrences(of: "#?", with: estimatedDate)
        
//        let headers = [
//          "Content-Type": "application/json",
//          "Authorization": "Bearer \(tmpToken)"
//        ]
        
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
        
        NetworkManager.call(url: "/create-quest-proposal", json: json, Completion: {(responseJSON) in
            self.showToast(message: "Proposal sent")
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
        })
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        // let localhost = "http://127.0.0.1:8080/api"
//        let url = URL(string: "\(apiPath)/create-quest-proposal")!
//        print("sending request to \(url)")
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        print(request)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            do {
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let responseJSON = responseJSON as? [String: Any] {
//                    print(responseJSON)
//                    self.showToast(message: "Proposal sent")
//                    DispatchQueue.main.async {
//                        self.dismiss(animated: false, completion: nil)
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()

    }
}
