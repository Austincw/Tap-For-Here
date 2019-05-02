//
//  ViewCoursesViewController.swift
//  Tap For Here
//
//  Created by Austin Washington on 5/1/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewCoursesViewController: UIViewController {

    var studEmail = UserDefaults.standard.string(forKey: "Student Email")
    
    @IBOutlet weak var pageTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showStudCourses()
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "coursesSegue", sender: self)
    }
    
    func showStudCourses(){
        
        let delim = "@"
        let studEmailKey = studEmail!.components(separatedBy: delim)
        
        let courseRef = Database.database().reference()
//        courseRef.child("ClassList").queryOrdered(byChild: "roster").queryEqual(toValue: "acwashi1").observe(.value, with: {(snapshot) in
        courseRef.child("StudentCourses").child(studEmailKey[0]).queryOrderedByKey().observe(.value, with: {(snapshot) in
            
            var yPos = 120
            for data in snapshot.children {

                let courseID = (data as AnyObject).key as String
                let label = UILabel()
                label.text = courseID
//                label.textAlignment = .center
                
                label.font = UIFont(name: "Avenir", size: 25)
                label.textColor = UIColor(red: 250/255, green: 211/255, blue: 56/255, alpha: 1.0)
                
                label.center = self.view.center
//                let width = self.view.center.x
//                [self.label setCenter:view.center];
                label.frame = CGRect(x: 95, y: yPos, width: 200, height: 80)
//                label.center = self.view.center
                self.view.addSubview(label)
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant:0).isActive = true
                yPos += 50
            }
//            if self.foundCourse == false {
//                let notfound = ViewController()
//                notfound.courseNotFound()
//            }
        })
        

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
