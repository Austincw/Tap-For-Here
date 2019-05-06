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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class SecondViewController: UIViewController, GIDSignInUIDelegate,  UIScrollViewDelegate, UITextFieldDelegate {
    //Firebase usage
    var db: DatabaseReference!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var fullname: String!
    var studentEmail = UserDefaults.standard.string(forKey: "Student Email")
    var registerButtonView = UserDefaults.standard.bool(forKey: "Register Button")
    var coursesButtonView = UserDefaults.standard.bool(forKey: "View Courses Button")
    
    
    //renamed text fields to be relevant to inputs
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var confirmEmailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var validEmailLabel: UILabel!
    @IBOutlet weak var emailMismatchLabel: UILabel!
    @IBOutlet weak var nameMismatchLabel: UILabel!
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBOutlet weak var buttonOnSecondView:
    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signIn()
        
//        buttonOnSecondView.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        UserDefaults.standard.set(true, forKey: "Register Button")
        UserDefaults.standard.set(false, forKey: "View Courses Button")
        performSegue(withIdentifier: "segue", sender: self)
        
        
    }
    
    
    //makes sure the email inputted follows the format of "username@aggies.ncat.edu"
    func validateStudentEmail(studentEmail: String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@aggies\\.ncat\\.edu"  // make everything after the @ only match aggies.ncat.edu
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (emailTest.evaluate(with: studentEmail)){
            validEmailLabel.isHidden = true
            return false
        }else{
            validEmailLabel.isHidden = false
            return true
        }
    }
    
    
    //Check for missing input and email matching
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
    
//    func checkGoogleSignIn(){
//        print("inside sign check")
//        DispatchQueue.main.async {
//
//
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil {
//                // user is signed in
//
//                print("signed in")
//                self.signInCheck = false
//                completion(false)
//                DispatchQueue.main.async {
//                    self.signInCheck = false
//                }
//            } else {
//                // user is not signed in
//                let notSignedIn = UIAlertController(title: "Not Signed In", message: "You must Sign-In into Google with NCAT Email to proceed", preferredStyle: .alert)
//
//                notSignedIn.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(notSignedIn, animated: true)
//
//
//                print("not signed in")
//                self.signInCheck = true
//                completion(true)
//                DispatchQueue.main.async {
//                    self.signInCheck = true
//                }
//            }
//
//
//        }
//        }
//    }
    
  
    
    
    @IBAction func submitInfo(_ sender: Any) {
        
//        try! Auth.auth().signOut()
        
        //Calls to check text fields, correct email input, and google sign-in
        email = String(emailField.text!)
        let checkFields: Bool = checkAndValidateFields()
        let checkEmail: Bool =  validateStudentEmail(studentEmail: email!)
        if (checkFields || checkEmail) {
            print("failed")
            return
        }
        
        
        firstName = String(firstNameField.text!)
        lastName = String(lastNameField.text!)
        let nameRegEx = "[-a-zA-Z' ]{2,26}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        if(nameTest.evaluate(with: firstName!) && nameTest.evaluate(with: lastName!)){
            nameMismatchLabel.isHidden = true
        }else{
            nameMismatchLabel.isHidden = false
            return
        }
        
        firstNameField.text = ""
        lastNameField.text = ""
        emailField.text = ""
        confirmEmailField.text = ""
        
        //Saving the students email to persistent storage on device
        UserDefaults.standard.set(email!, forKey: "Student Email")
        
        fullname = "\(firstName!) \(lastName!)"
//        let emailUserName = email!.components(separatedBy: "@")//NOT SURE IF NEEDED, KEEP FOR NOW
        sendRegisterInfo(name: fullname!, studentEmail: email!)
        
    }
    
    
}
