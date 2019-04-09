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

class SecondViewController: UIViewController, GIDSignInUIDelegate,  UIScrollViewDelegate {
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
    @IBOutlet weak var confirmEmailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var validEmailLabel: UILabel!
    @IBOutlet weak var emailMismatchLabel: UILabel!
    
    
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
    
    //Function used to send information inputted when the student registers to the database
    func sendRegisterInfo(name: String, studentEmail: String){
        
        db = Database.database().reference()
        self.db.child("RegisteredStudents").updateChildValues([name: studentEmail])
        
    }
    
    //makes sure the email inputted follows the format of "username@aggies.ncat.edu"
    func validateStudentEmail(studentEmail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@\W*[aggies.ncat.edu]" // make everything after the @ only match aggies.ncat.edu
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (emailTest.evaluate(with: studentEmail)){
            validEmailLabel.isHidden = true
            return false
        }else{
            validEmailLabel.isHidden = false
            return true
        }
    }
    
    func checkAndValidateFields() -> Bool {
        
        //Checks if the user is missing input in a text field
        if ((firstNameField.text?.isEmpty) ?? true || (lastNameField.text?.isEmpty) ?? true || (emailField.text?.isEmpty) ?? true || (confirmEmailField.text?.isEmpty) ?? true){
            
            let missingInput = UIAlertController(title: "Missing Input", message: "Please make sure all fields have been filled out", preferredStyle: .alert)
            
            missingInput.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(missingInput, animated: true)
            return true
            
        } else if (emailField.text! != confirmEmailField.text!){ //Check to make sure they entered their email correctly
            
            emailMismatchLabel.isHidden = false
            return true
            
        }else{
            emailMismatchLabel.isHidden = true
            return false
        }
        
    }
    
    
    @IBAction func submitInfo(_ sender: Any) {
        
        //Call to check text fields for correct input
        email = String(emailField.text!)
        let checkFields: Bool = checkAndValidateFields()
        let checkEmail: Bool =  validateStudentEmail(studentEmail: email!)
        if (checkFields || checkEmail) {
            return
        }
        
        firstName = String(firstNameField.text!)
        lastName = String(lastNameField.text!)
        firstNameField.text = ""
        lastNameField.text = ""
        emailField.text = ""
        confirmEmailField.text = ""
        
        //Saving the students email to persistent storage on device
        UserDefaults.standard.set(email!, forKey: "Student Email")
        
        fullname = "\(firstName!) \(lastName!)"
//        sendRegisterInfo(name: fullname!, studentEmail: email!)
        
    }
    
    
}
