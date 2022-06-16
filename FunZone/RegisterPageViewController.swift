//
//  RegisterPageViewController.swift
//  FunZone
//
//  Created by admin on 6/5/22.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userName = userTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = userRepeatPasswordTextField.text
        
        // Check for empty fields
        if((userName?.isEmpty) != nil || ((userPassword?.isEmpty) != nil) || ((userRepeatPassword?.isEmpty) != nil)) {
            
            displayMyAlertMessage(userMessage: String)
            print("All fields are required")
            return
        }
        
        if(userPassword != userRepeatPassword) {
            
            displayMyAlertMessage(userMessage: String)
            print("Passwords do not match")
            return
        }
        
        // Store data
        
        
        // Display alert message with confirmation
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertAction.alert)
        
    }

}
