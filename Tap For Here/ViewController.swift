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

public extension UIAlertController {
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}


class ViewController: UIViewController{
    
    var studEmail = UserDefaults.standard.string(forKey: "Student Email") ?? nil
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueInfo", sender: self)
    }
    
    
    @IBOutlet weak var viewCoursesButton: UIButton!
    @IBAction func viewCoursesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "coursesSegue", sender: self)
    }
    
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var roundedCornerButton: UIButton!
    
    var session: NFCNDEFReaderSession?
    var scannedMsg: String!

    
    let scanTag = NFCReadTag()
    let recAttend = RecordAttendance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isHidden = (UserDefaults.standard.value(forKey: "Register Button") as? Bool) ?? false
        viewCoursesButton.isHidden = (UserDefaults.standard.value(forKey: "View Courses Button") as? Bool) ?? true
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //This function occurs when you tap for here
    @IBAction func scanButtonAction(_ sender: Any) {
        
        if studEmail == nil{
            let notRegistered = UIAlertController(title: "Not Registered!", message: "Please make sure you register first before attempting to use this feature.", preferredStyle: .alert)
            notRegistered.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            notRegistered.show()
            return
        }
        
        let simScan: String = scanTag.simReadNFC() //Simulate reading an NFC Tag
        recAttend.determineAttendance(roomID: simScan) // FOR SIMULATION PURPOSES
//        scanTag.start() // Read Physical NFC Tag
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { // USED FOR SIMULATION, COMMENT OUT WHEN FINISHED TESTING

            if self.recAttend.foundCourse == false {
                self.courseNotFound()
            }else if self.recAttend.foundCourse == true{
                self.markAttendanceSuccess()
            }
        })


    }
    
    func passToAttendance(tagMsg: String){
        recAttend.determineAttendance(roomID: tagMsg) // Record student attendance
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            
            if self.recAttend.foundCourse == false {
                self.courseNotFound()
            }
        })
    }
    
    func courseNotFound(){
        
        let notFound = UIAlertController(title: "Not Found!", message: "There isn't a course registered here at this time!", preferredStyle: .alert)
        notFound.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        notFound.show()
//            self.present(notFound, animated: true)
        
    }
    
    func markAttendanceSuccess(){
        let foundClass = UIAlertController(title: "Success!", message: "You've been recorded for this class today.", preferredStyle: .alert)
        foundClass.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        foundClass.show()
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
