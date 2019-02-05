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
    @IBOutlet weak var invalidPasswordText: UILabel!
    
    
    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
        guard let emailAddress = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let confirmPassword = passwordConfirmationTextField.text else {return}
        
        if(password == confirmPassword){
            Auth.auth().createUser(withEmail: emailAddress, password: password) { (user, error) in
                if user != nil, error == nil{
                self.dismiss(animated: true, completion: nil)
                }
                else{
                    print(error.debugDescription)
                }
            }
        }
        else{
            invalidPasswordText.isHidden=false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.delegate=self
        passwordTextField.delegate=self
        passwordConfirmationTextField.delegate=self
        
        emailAddressTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true
        passwordConfirmationTextField.isSecureTextEntry = true

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else if(passwordTextField.isFirstResponder){
            passwordConfirmationTextField.becomeFirstResponder()
        }
        else{
            passwordConfirmationTextField.resignFirstResponder()
            signUpButton.isEnabled=true
        }
        return true
    }
    
}
