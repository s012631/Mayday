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
    
    @IBOutlet weak var safetyReleaseTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var information: Settings?
    
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
        
        let code: [String: Any] = ["Code": safetyReleaseTextField]
    
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("user/\(uid)")
        databaseRef.updateChildValues(["EmergencyContact1": self.EmergencyContactsTextFields[0].text, "EmergencyContact2": self.EmergencyContactsTextFields[1].text, "EmergencyContact3": self.EmergencyContactsTextFields[2].text, "Phone1": self.PhoneNumbersTextFields[0].text, "Phone2": self.PhoneNumbersTextFields[1].text, "Phone3": self.PhoneNumbersTextFields[2].text, "Name": self.name.text, "Alarm": self.alarmTextField.text, "Code": self.safetyReleaseTextField.text], withCompletionBlock: { (Error, DatabaseReference) in
            if Error != nil{
                print(Error)
                return
            }
        })
        
//        print("is sharing")
//        self.codeText = safetyReleaseTextField.text ?? ""
//        performSegue(withIdentifier: "settingsToMayday", sender: self)
//
        
    }
    
    @IBAction func backButtonTouchedUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingsToMayday", sender: self)
    }
    
    

    @IBAction func logoutButtonTouchedUp(_ sender: UIButton){
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "settingsToLogin", sender: self)
//        self.dismiss(animated: true, completion: nil)
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
        else if alarmTextField.isFirstResponder{
            safetyReleaseTextField.becomeFirstResponder()
        }
        else{
            safetyReleaseTextField.resignFirstResponder()
            saveButton.isEnabled = true
        }
        return true
    }
    
    
    @IBAction func ChangePhotoTouchedUp(_ sender: UIButton) {
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func setUserInfo(){
        information = Settings()
        information?.getUserInfo({ (userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode) in
            if let info = self.information{
                self.name.text = info.nameRef
                self.EmergencyContactsTextFields[0].text = info.contact1Ref
                self.EmergencyContactsTextFields[1].text = info.contact2Ref
                self.EmergencyContactsTextFields[2].text = info.contact3Ref
                self.PhoneNumbersTextFields[0].text = info.phone1Ref
                self.PhoneNumbersTextFields[1].text = info.phone2Ref
                self.PhoneNumbersTextFields[2].text = info.phone3Ref
                self.alarmTextField.text = info.alarmRef
                self.safetyReleaseTextField.text = info.safetyCodeRef
                self.reloadInputViews()
            }
        })
        
//        if let info = information{
//            print("is assigning")
//            self.name.text = info.nameRef
//            print(info.nameRef)
//            self.EmergencyContactsTextFields[0].text = info.contact1Ref
//            self.EmergencyContactsTextFields[1].text = info.contact2Ref
//            self.EmergencyContactsTextFields[2].text = info.contact3Ref
//            self.PhoneNumbersTextFields[0].text = info.phone1Ref
//            self.PhoneNumbersTextFields[1].text = info.phone2Ref
//            self.PhoneNumbersTextFields[2].text = info.phone3Ref
//            self.alarmTextField.text = info.alarmRef
//            self.safetyReleaseTextField.text = info.safetyCodeRef
//            self.reloadInputViews()
//        }
    }
    
//    func getUserInfo(_ completion: @escaping((_ name:String?, _ contact1: String?, _ contact2: String?, _ contact3: String?, _ alarm: String?, _ phone1: String?, _ phone2: String?, _ phone3: String?, _ safetyCode: String?)  -> ())){
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let databaseRef = Database.database().reference().child("user/\(uid)")
//
//        var userName: String?
//        var contact1: String?
//        var contact2: String?
//        var contact3: String?
//        var alarm: String?
//        var phone1: String?
//        var phone2: String?
//        var phone3: String?
//        var safetyCode: String?
//
//        databaseRef.observeSingleEvent(of: .value, with: { snapshot  in
//            let dictionary = snapshot.value as? [String : AnyObject] ?? [:]
//
//            if let name = dictionary["Name"] {
//                userName = name as? String
//            }
//            if let eContact1 = dictionary["EmergencyContact1"]{
//                contact1 = eContact1 as? String
//            }
//            if let eContact2 = dictionary["EmergencyContact2"]{
//                contact2 = eContact2 as? String
//            }
//            if let eContact3 = dictionary["EmergencyContact3"]{
//                contact3 = eContact3 as? String
//            }
//            if let alarmCompany = dictionary["Alarm"]{
//                alarm = alarmCompany as? String
//            }
//            if let firstPhone = dictionary["Phone1"]{
//                phone1 = firstPhone as? String
//            }
//            if let secondPhone = dictionary["Phone2"]{
//                phone2 = secondPhone as? String
//            }
//            if let thirdPhone = dictionary["Phone3"]{
//                phone3 = thirdPhone as? String
//            }
//            if let safeCode = dictionary["Code"]{
//                safetyCode = safeCode as? String
//            }
//
//            completion(userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode)
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
  
        setUserInfo()
        print("is setting user info")
        
//        getUserInfo() { userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode in
//            self.name.text = userName
//            self.EmergencyContactsTextFields[0].text = contact1
//            self.EmergencyContactsTextFields[1].text = contact2
//            self.EmergencyContactsTextFields[2].text = contact3
//            self.PhoneNumbersTextFields[0].text = phone1
//            self.PhoneNumbersTextFields[1].text = phone2
//            self.PhoneNumbersTextFields[2].text = phone3
//            self.alarmTextField.text = alarm
//            self.safetyReleaseTextField.text = safetyCode
//            self.reloadInputViews()
//        }
        
        
        name.delegate = self
        for aTextField in EmergencyContactsTextFields{
            aTextField.delegate = self
        }
        for aTextField in PhoneNumbersTextFields{
            aTextField.delegate = self
        }
        alarmTextField.delegate = self
        safetyReleaseTextField.delegate = self
        safetyReleaseTextField.isSecureTextEntry = true
        name.becomeFirstResponder()
    
     //   shareInfo()
        
    }
    
    
//    func shareInfo(){
//        print("is sharing")
//        self.codeText = safetyReleaseTextField.text ?? ""
//        performSegue(withIdentifier: "settingsToMayday", sender: self)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("is preparing")
//        var vc = segue.destination as? MayDayHome
//        vc?.finalCode = self.codeText
//    }
    
}

