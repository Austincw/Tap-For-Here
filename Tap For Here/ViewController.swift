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
    
    
    
    @IBOutlet weak var roundedCornerButton: UIButton!
    var ref: DatabaseReference!
    var session: NFCNDEFReaderSession?
    
    let terst = NFCReadTag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        roundedCornerButton.layer.cornerRadius = 26
        // Do any additional setup after loading the view, typically from a nib.
        
    }


    @IBAction func action(_ sender: Any) {
        print("*****")
    
        terst.start() // Read NFC Tag
        terst
        
    }
    
    
}
