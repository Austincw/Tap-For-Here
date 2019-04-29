//
//  ViewController.swift
//  Tap For Here
//
//  Created by Zachary Solomon on 2/25/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreNFC

//class NFCNDEFReaderSession: NFCNDEFReaderSession{
//    init(delegate: NFCNDEFReaderSessionDelegate, queue: DispatchQueue?, invalidateAfterFirstRead: Bool)
//}

class ViewController: UIViewController{
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueInfo", sender: self)
    }
    
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var roundedCornerButton: UIButton!
    
    var session: NFCNDEFReaderSession?
    var scannedMsg: String!
    
    let scanTag = NFCReadTag()
    let recAttend = RecordAttendance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanButton.setTitleColor(UIColor.gray, for: .disabled)
//        topButton.layer.cornerRadius = 40
//        roundedCornerButton.layer.cornerRadius = 26
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //This function occurs when you tap for here
    @IBAction func scanButtonAction(_ sender: Any) {
        

        let simScan:String = scanTag.simReadNFC() //Simulate reading an NFC Tag
//        scanTag.start() // Read Physical NFC Tag
        



//        let simScan:String = scanTag.simReadNFC() //Simulate reading an NFC Tag
        scanTag.start() // Read Physical NFC Tag

    }
    
    func passToAttendance(tagMsg: String){
         recAttend.determineAttendance(roomID: tagMsg) // Record student attendance

    }
    
    //This function occurs when you tap "Register"
    @IBAction func action(_ sender: Any) {
        
        
    }
    
    //This function occurs during the transition from ViewController to SecondViewController ***also when you tap "Register"****
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondViewController" {
            
            let secondViewController = segue.destination as! SecondViewController

        }
    }
}
