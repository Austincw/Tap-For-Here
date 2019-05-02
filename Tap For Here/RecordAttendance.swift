//
//  RecordAttendance.swift
//  Tap For Here
//
//  Created by Austin Washington on 4/8/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class RecordAttendance: NSObject {
    
    var db: DatabaseReference!
    var studEmail = UserDefaults.standard.string(forKey: "Student Email") ?? ""
    var myCourse: String?
    var foundCourse = false
    
    
    // Function to mark the student down for attendance in the correct class
    func markAttendanceRecord(currentCourse: String){
        
        let delim = "@"
        let studEmailKey = studEmail.components(separatedBy: delim)
        
        let date = NSDate()
        let format = DateFormatter()
        format.timeZone = TimeZone.current
        format.dateFormat = "MM-dd"
        let currentDay = format.string(from: date as Date)
        
        let markAttenRef = Database.database().reference()
        markAttenRef.child("ClassList").child(currentCourse).child("roster").updateChildValues(["acwashi1": true]) // USED FOR TESTING
        markAttenRef.child("ClassAttendance").child(currentCourse).child("01-09").updateChildValues(["acwashi1": true])  // USED FOR TESTING

//        markAttenRef.child("ClassList").child(currentCourse).child("roster").updateChildValues([studEmailKey[0]: true])  // REAL VERSION TO RUN
//        markAttenRef.child("ClassAttendance").child(currentCourse).child(currentDay).updateChildValues([studEmailKey[0]: true])  // REAL VERSION TO RUN

        
        
        
    }
    
    //********************************
    //*** Core Attendance function ***
    func determineAttendance(roomID: String){
        
        db = Database.database().reference()
        
        let courseRef = Database.database().reference()
        courseRef.child("ClassData").queryOrdered(byChild: "roomID").queryEqual(toValue: roomID).observe(.value, with: {(snapshot) in
            
            for data in snapshot.children {
                
                let courseID = (data as AnyObject).key as String
                
                self.checkCourseData(course: courseID){ (myCourse) -> () in
                    if self.foundCourse == true{
                        self.markAttendanceRecord(currentCourse: myCourse)
                    }else{
                        print("no course found")
                    }
                }
            }
            
        })
        
        
    }
    //** End of Attendance function **
    //********************************
    
 
    func checkCourseData(course: String, completion: @escaping (String)->()){
        
        let date = NSDate()
        let format = DateFormatter()
        format.timeZone = TimeZone.current
        format.dateFormat = "HHmm"
        let currentTime = format.string(from: date as Date)
        let timeInt = Int(currentTime)!
        
        //GET FIRST LETTER OF DAY OF WEEK
        let weekday = format.weekdaySymbols[Calendar.current.component(.weekday, from: date as Date)-1]
        let weekDayLetter = Array(weekday)
        
        
        let timeRef = Database.database().reference()
        timeRef.child("ClassData").child(course).observe(.value, with: {(snapshot) in
            
            let snap = snapshot.value as? NSDictionary
            let daysOfWeek = snap!["days"] as? String
            let startT = snap!["startTime"] as? String
            let endT = snap!["endTime"] as? String
            

//            if (Int(startT!)! <= timeInt && timeInt <= Int(endT!)! && (daysOfWeek?.contains(weekDayLetter[0]))!) { // The official version
//                self.foundTime = true
//                completion(course)
//            }
            
            let testTime = 1615
            let dayLetterTest = "M"
            if (Int(startT!)! <= testTime && testTime <= Int(endT!)! && (daysOfWeek?.contains(dayLetterTest))!) { //THIS ONE IS USED FOR TESTING
                self.foundCourse = true
                completion(course)
            }
            
        })
        
    }
    
    
    
}
