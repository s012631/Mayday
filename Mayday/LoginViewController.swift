//
//  LoginViewController.swift
//  Mayday
//
//  Created by Gabriel Hummel (student LM) on 1/8/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButtonTouchedUp(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate=self
        emailAddressTextField.delegate=self
        emailAddressTextField.becomeFirstResponder()
    }
}
