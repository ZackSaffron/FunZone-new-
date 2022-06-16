//
//  RegisterViewController.swift
//  FunZone
//
//  Created by admin on 6/5/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var ErrorMessage: UILabel!
    @IBOutlet weak var rememberMeRegister: UISwitch!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func register(_ sender: Any) {
           signUp()
           savePasswordToKeyChain()
        }
            
        func didRegisterAccountValidation(input: String?) -> Bool {
            var validInput = false
            if input != nil && input != "" && !input!.isEmpty {
                validInput = true
            }
            return validInput
        }
        
    func didRegisterAccountNewUser(username: String) -> Bool {
        let newUser = !DBHelperUser.dbHelperUser.isUserRegistered(username: username)
        return newUser
    }

    
    func signUp() {
        let username = username.text!
        let password = password.text!
        if !(didRegisterAccountValidation(input: username) && didRegisterAccountValidation(input: password)) {
            ErrorMessage.text = "Please input username/password."
        } else {
            if DBHelperUser.dbHelperUser.isUserRegistered(username: username) {
                ErrorMessage.text = "You registered already, go to log in page."
            } else {
                DBHelperUser.dbHelperUser.createUser(usernameValue: username, passwordValue: password)
                ErrorMessage.text = "Registered succesfully! Please log in."
            }
        }
        
    }
    
    func savePasswordToKeyChain() {
        if rememberMeRegister.isOn {
            //save password to keychain
            let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username.text]
            
            let attributeUsername : [String : Any] = [kSecAttrAccount as String : username]
            let attributePassword : [String : Any] = [kSecValueData as String : password.text!.data(using: .utf8)]
            
            if SecItemUpdate(request as CFDictionary, attributePassword as CFDictionary) == noErr && SecItemUpdate(request as CFDictionary, attributeUsername as CFDictionary) == noErr {
                print("Password saved in keychain.")
            } else {
                print("Error.")
            }
            //save this user to userDefaults
            let userDefaults = UserDefaults.standard
            userDefaults.set(username.text!, forKey: "UserRemembered")
        }
    }
}
