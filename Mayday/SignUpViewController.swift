//
//  SignUpViewController.swift
//  Mayday
//
//  Created by Gabriel Hummel (student LM) on 1/8/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
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
        else if(passwordTextField.isFirstResponder){
            passwordConfirmationTextField.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
            passwordConfirmationTextField.resignFirstResponder()
            signUpButton.isEnabled=true
        }
        
        return true
    }
    
}
