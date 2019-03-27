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

class SettingsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker : UIImagePickerController?
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet var EmergencyContactsTextFields: [UITextField]!
    
    @IBOutlet var PhoneNumbersTextFields: [UITextField]!
    
    @IBOutlet weak var alarmTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
 // link to how to use firebase   https://firebase.google.com/docs/database/ios/read-and-write
    @IBAction func saveButtonTouchedUp(_ sender: UIButton) {
        
        let emergencyContact1: [String: Any] = ["EmergencyContact1": EmergencyContactsTextFields[0].text]
        let emergencyContact2: [String: Any] = ["EmergencyContact2": EmergencyContactsTextFields[1].text]
        let emergencyContact3: [String: Any] = ["EmergencyContact3": EmergencyContactsTextFields[2].text]
 
        let phone1: [String: Any] = ["Phone1": PhoneNumbersTextFields[0].text]
        let phone2: [String: Any] = ["Phone2": PhoneNumbersTextFields[1].text]
        let phone3: [String: Any] = ["Phone3": PhoneNumbersTextFields[2].text]

        let nameLabel: [String: Any] = ["Name": name.text]
        
        let alarm: [String: Any] = ["Alarm": alarmTextField.text]
        
    
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("user/\(uid)")
        databaseRef.updateChildValues(["EmergencyContact1": self.EmergencyContactsTextFields[0].text, "EmergencyContact2": self.EmergencyContactsTextFields[1].text, "EmergencyContact3": self.EmergencyContactsTextFields[2].text, "Phone1": self.PhoneNumbersTextFields[0].text, "Phone2": self.PhoneNumbersTextFields[1].text, "Phone3": self.PhoneNumbersTextFields[2].text, "Name": self.name.text, "Alarm": self.alarmTextField.text], withCompletionBlock: { (Error, DatabaseReference) in
            if Error != nil{
                print(Error)
                return
            }
        })
        
    }
    
    
    

    @IBAction func logoutButtonTouchedUp(_ sender: UIButton){
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func ChangePhotoTouchedUp(_ sender: UIButton) {
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
       
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("user/\(uid)")
        var userName : String?
        
        databaseRef.observe(.childAdded, with: { (snapshot) in
            // This if statement is not executing
            if let dictionary = snapshot.value as? [String : String] {
                print("ran")
                userName = dictionary["Name"] as? String
                print(userName)
               
            }
        })
        
        
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
    
        
        
}

