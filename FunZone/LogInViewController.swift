//
//  SignInViewController.swift
//  FunZone
//
//  Created by admin on 6/5/22.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMeLogIn: UISwitch!
    
    @IBOutlet weak var ErrorMessage: UILabel!
    @IBAction func buttonLogIn(_ sender: Any) {
        //1. validate username and password inputs
        let usernameTextField = username.text!
        let passwordTextField = password.text!
        
        func checkInput(text : String) -> Bool {
            var isValid = false
            if !text.isEmpty && text != "" && text != nil {
                isValid = true
            }
            return isValid
        }
        
        if checkInput(text: usernameTextField) && checkInput(text: passwordTextField) {
            //check if user is registered
            if !DBHelperUser.dbHelperUser.isUserRegistered(username: usernameTextField) {
                ErrorMessage.text = "Please sign in first"
            }
            //check if password is correct
            //let correctPassword = DBHelperUser.dbHelperUser.getOne(username: usernameTextField!).password
            let user = DBHelperUser.dbHelperUser.getOne(username: usernameTextField)
            let correctPassword = user.password
            if passwordTextField == correctPassword {
                //present the tab bar controller in full screen
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNextScreen = storyboard.instantiateViewController(withIdentifier: "tabBar")
                //show the tab controller as an instantiated vc
                loginNextScreen.modalPresentationStyle = .fullScreen
                self.present(loginNextScreen, animated: true, completion: nil)
                //save password to keychain if remember me is on
                savePassword()
            } else {
                ErrorMessage.text = "Please check username/password."
            }
        } else {
            ErrorMessage.text = "Please input username/password."
        }
        //2. save password to keychain if remember me is on
        func savePassword() {
            if rememberMeLogIn.isOn {
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //show up username and password for users switched on "remember me"
        let userDefaults = UserDefaults.standard
        let user = userDefaults.string(forKey: "UserRemembered")
        username.text = user
        
        //get password from keychain and show in the textfield
//        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : user!, kSecReturnAttributes as String : true, kSecReturnData as String : true]
//        var response : CFTypeRef?
//        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
//            let data = response as? [String : Any]
//            let username = data![ kSecAttrAccount as String] as? String
//            let passwordEncrypted = (data![ kSecValueData as String] as? Data)!
//            let passwordUnencrypted = String(data: passwordEncrypted, encoding: .utf8)
//            print(username!,passwordUnencrypted!)
//            password.text = passwordUnencrypted
//        } else {
//            print("Error.")
//        }
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
