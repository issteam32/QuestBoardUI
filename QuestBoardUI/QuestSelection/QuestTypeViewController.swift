//
//  QuestTypeViewController.swift
//  QuestBoardUI
//
//  Created by Adam Teng Guan Tan on 21/4/21.
//

import UIKit

class QuestTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEveryday(_ sender: Any) {
        
        performSegue(withIdentifier: "everyday", sender: self);
        
    }
    
    @IBAction func btnProfessional(_ sender: Any) {
        
        performSegue(withIdentifier: "professional", sender: self);
        
    }
    
    
    
    
}
