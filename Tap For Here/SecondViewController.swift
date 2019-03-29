//
//  SecondViewController.swift
//  Tap For Here
//
//  Created by Zachary Solomon on 3/14/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase

class SecondViewController: UIViewController, GIDSignInUIDelegate {
    //Firebase usage
    var db: DatabaseReference!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var fullname: String!

    
    //renamed text fields to be relevant to inputs
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var buttonOnSecondView:
    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signIn()
        
        buttonOnSecondView.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sendRegisterInfo(name: String, studentEmail: String){
         // This section of code is for testing writing data to Firebase when opening the second view controller, LEAVE FOR REFERENCE
        
        db = Database.database().reference()
        self.db.child("RegisteredStudents").updateChildValues([name: studentEmail])
        //        db.setValue(["/RegisteredStudents/": "TESTING"])
        
    }
    
    
    @IBAction func submitInfo(_ sender: Any) {
        firstName = String(firstNameField.text!)
        lastName = String(lastNameField.text!)
        email = String(emailField.text!)
        firstNameField.text = ""
        lastNameField.text = ""
        emailField.text = ""
        
        fullname = "\(firstName!) \(lastName!)"
        sendRegisterInfo(name: fullname!, studentEmail: email!)
        
//        print("First Name :\(firstName), Last Name: \(lastName), Email: \(email)")
    }
    
    
}
