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
    
    
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var roundedCornerButton: UIButton!
    
    var session: NFCNDEFReaderSession?
    var scannedMsg: String!
    
    let scanTag = NFCReadTag()
    let recAttend = RecordAttendance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topButton.layer.cornerRadius = 40
        roundedCornerButton.layer.cornerRadius = 26
        
        
    }
    
    //This function occurs when you tap for here
    @IBAction func topButtonAction(_ sender: Any) {
        


//        let simScan:String = scanTag.simReadNFC() //Simulate reading an NFC Tag
        scanTag.start() // Read Physical NFC Tag

    }
    
    func passToAttendance(msg: String){
         recAttend.determineAttendance(roomID: msg) // Record student attendance
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
