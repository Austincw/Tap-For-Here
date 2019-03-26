//
//  SecondViewController.swift
//  Tap For Here
//
//  Created by Zachary Solomon on 3/14/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var buttonOnSecondView:
    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOnSecondView.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}
