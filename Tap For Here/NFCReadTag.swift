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
    
    var ref: DatabaseReference!
    
    func start(){
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii){
                    print(string)
                    
                    ref = Database.database().reference()
                    ref.setValue(["username": string])
                }
            }
        }
    }
}
