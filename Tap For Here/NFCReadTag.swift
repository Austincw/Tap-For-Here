//
//  NFCReadTag.swift
//  Tap For Here
//
//  Created by Zachary Solomon on 2/28/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import Foundation
import CoreNFC
import Firebase
import FirebaseDatabase

class NFCReadTag: NSObject, NFCNDEFReaderSessionDelegate{
    
    var db: DatabaseReference!
    var tagMessage: String!
    var scannedMessage = [String]()
    
    
    //TESTING METHOD FOR READING NFC TAG ON IPHONE SIM
    //***** DELETE LATER *****
    func simReadNFC()-> String{
        return "Graham 210"
    }
    //************************
    
    
    func start(){
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    //Used for creating an NFC reader session to read contents on NFC tag
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]){
        for message in messages {
            for record in message.records {
                tagMessage = String.init(data: record.payload.advanced(by: 3), encoding: .utf8)!
                if (tagMessage != nil) {
                    
                    print(tagMessage)
<<<<<<< HEAD

=======
                
                    
                    
>>>>>>> 4b1455a6587f8b490ddbfeaebe6e3f7ca391288a
//                    db = Database.database().reference()
//                    db.updateChildValues(["username": tagMessage])
                }
            }
        }
    }
}
