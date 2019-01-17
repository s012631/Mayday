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

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func moveToSignUp(_ sender: UIButton) {
    }
    
    @IBAction func signInButtonTouchedUp(_ sender: UIButton) {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate=self
        emailAddressTextField.delegate=self
        emailAddressTextField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
            passwordTextField.resignFirstResponder()
            signInButton.isEnabled=true
        }
        return true
    }
}
