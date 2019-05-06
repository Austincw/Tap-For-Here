//
//  Alert.swift
//  Tap For Here
//
//  Created by Austin Washington on 5/1/19.
//  Copyright © 2019 Zachary Solomon. All rights reserved.
//

import Foundation
import UIKit


class Alert: UIAlertController{
    
    func showMyAlert(){
        let notFound = UIAlertController(title: "Not Found!", message: "There isn't a course registered here at this time!", preferredStyle: .alert)
        notFound.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(notFound, animated: true)
    }
    
    func showAlert(fromController controller: UIViewController) {
        let alert = UIAlertController(title: "abc", message: "def", preferredStyle: .alert)
        controller.present(alert, animated: true, completion: nil)
    }
   
    
}
