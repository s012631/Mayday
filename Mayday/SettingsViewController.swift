//
//  mayDayHome.swift
//  Mayday
//
//  Created by Itay Baror (student LM) on 1/9/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet var EmergencyContactsTextFields: [UITextField]!
    
    @IBOutlet var PhoneNumbersTextFields: [UITextField]!
    
    @IBOutlet weak var alarmTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func logoutButtonTouchedUp(_ sender: UIButton){
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        name.delegate = self
        for aTextField in EmergencyContactsTextFields{
            aTextField.delegate = self
        }
        for aTextField in PhoneNumbersTextFields{
            aTextField.delegate = self
        }
        alarmTextField.delegate = self
        name.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if name.isFirstResponder{
            EmergencyContactsTextFields[0].becomeFirstResponder()
        }
        else if EmergencyContactsTextFields[0].isFirstResponder{
            PhoneNumbersTextFields[0].becomeFirstResponder()
        }
        else if PhoneNumbersTextFields[0].isFirstResponder{
            EmergencyContactsTextFields[1].becomeFirstResponder()
        }
        else if EmergencyContactsTextFields[1].isFirstResponder{
            PhoneNumbersTextFields[1].becomeFirstResponder()
        }
        else if PhoneNumbersTextFields[1].isFirstResponder{
            EmergencyContactsTextFields[2].becomeFirstResponder()
        }
        else if EmergencyContactsTextFields[2].isFirstResponder{
            PhoneNumbersTextFields[2].becomeFirstResponder()
        }
        else if PhoneNumbersTextFields[2].isFirstResponder{
            alarmTextField.becomeFirstResponder()
        }
        else{
            alarmTextField.resignFirstResponder()
            saveButton.isEnabled = true
        }
        return true
    }
}

