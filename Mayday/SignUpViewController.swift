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
    
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var invalidPasswordsText: UILabel!
    
    @IBAction func signUpButtonTouched(_ sender: UIButton) {
        
        
        print("account touched")
        guard let emailAddress = emailAddressTextField.text else {return}
        guard let passwordConfirmation = passwordConfirmationTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        print(emailAddress)
        print(password)
        print(passwordConfirmation)
        if(password == passwordConfirmation){
            print("match")
        }
        if(password == passwordConfirmation){
            Auth.auth().createUser(withEmail: emailAddress, password: password) { (user, error) in
                if user != nil, error == nil{
                    print("account created")
                    self.performSegue(withIdentifier: "signUpToLogin", sender: self)
                }
                else if user == nil{
                    print("no user")
                    print(error.debugDescription)
                }
                else if error != nil{
                    print("error")
                    print(error.debugDescription)
                    if user == nil{
                        print("and no user")
                    }
                }
            }
        }
        else{
            invalidPasswordsText.isHidden=false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.delegate=self
        passwordTextField.delegate=self
        passwordConfirmationTextField.delegate=self
        invalidPasswordsText.isHidden=true
        emailAddressTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true
        passwordConfirmationTextField.isSecureTextEntry = true
        signUpButton.isEnabled=false
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
