//
//  LoginViewController.swift
//  Mayday
//
//  Created by Gabriel Hummel (student LM) on 1/8/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var incorrectInput: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func moveToSignUp(_ sender: UIButton) {
    }
    
    
    @IBAction func signInButtonTouchedUp(_ sender: UIButton) {
        print("touched")
        guard let emailAddress = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            print("tried")
            if error == nil && user != nil{
                self.performSegue(withIdentifier: "loginToSegue", sender: self)
    
                print("signed in")
            }
            else if user == nil||error != nil{
                print("not signed in")
                self.incorrectInput.isHidden=false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectInput.isHidden=true
        passwordTextField.delegate=self
        emailAddressTextField.delegate=self
        emailAddressTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            signInButton.isEnabled = true
        }
        return true
    }
}
