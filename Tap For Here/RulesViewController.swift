//
//  RulesViewController.swift
//  Tap For Here
//
//  Created by Austin Washington on 4/28/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    
    @IBAction func acceptButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueRules", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
