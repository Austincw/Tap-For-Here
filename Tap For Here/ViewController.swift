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
    
    let scanTag = NFCReadTag()
    let recAttend = RecordAttendance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topButton.layer.cornerRadius = 40
        roundedCornerButton.layer.cornerRadius = 26
        
        
    }
    
    //This function occurs when you tap for here
    @IBAction func topButtonAction(_ sender: Any) {
        
<<<<<<< HEAD
=======
//        let simScan:String = scanTag.simReadNFC() //Simulate reading an NFC Tag
        scanTag.start() // Read Physical NFC Tag
        recAttend.determineAttendance(roomID: scanTag.scannedMessage[1]) // Record student attendance
        
>>>>>>> 4b1455a6587f8b490ddbfeaebe6e3f7ca391288a
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
