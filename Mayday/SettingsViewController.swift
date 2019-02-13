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
    
    
    @IBAction func saveButtonTouchedUp(_ sender: UIButton) {
        
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
    
//    override func viewDidLoad() {
//      super.viewDidLoad()
//        name.delegate = self
//        for aTextField in EmergencyContactsTextFields{
//            aTextField.delegate = self
//        }
//        for aTextField in PhoneNumbersTextFields{
//            aTextField.delegate = self
//        }
//        alarmTextField.delegate = self
//        name.becomeFirstResponder()
//        
//        // image work
//        imageView.layer.borderWidth = 1
//        imageView.layer.masksToBounds = false
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.cornerRadius = imageView.frame.height/2
//        imageView.clipsToBounds = true
//        
//        imagePicker = UIImagePickerController()
//        imagePicker?.allowsEditing = true
//        imagePicker?.sourceType = .photoLibrary
//        imagePicker?.delegate = self
//        
//        // Downloading image from storage when view loads
//        getImageURL(){ url in
//            
//            let storage = Storage.storage()
//            guard let imageURL = url else {return}
//            let ref = storage.reference(forURL: imageURL)
//            
//            ref.getData(maxSize: 1 * 1024 * 1024) {data, error in
//                if error == nil && data != nil{
//                    self.imageView.image = UIImage(data: data!)
//                    self.reloadInputViews()
//                }
//                else{
//                    print(error?.localizedDescription)
//                }
//            }
//        }
//        
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        imagePicker?.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
//            imageView.image = pickedImage // set the imageView to display the selected image
//            uploadProfilePicture(pickedImage) {url in
//                guard let uid = Auth.auth().currentUser?.uid else {return}
//                guard let imageURL = url else {return}
//                let database = Database.database().reference().child("users/\(uid)")
//                
//                let userObject: [String: Any] = ["photoURL": imageURL.absoluteString]
//                
//                database.setValue(userObject)
//            }
//        }
//        imagePicker?.dismiss(animated: true, completion: nil)
//    }
//    
//    func getImageURL(_ completion: @escaping((_ url:String?) -> ())){
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        
//        let databaseRef = Database.database().reference().child("users/\(uid)")
//        
//        databaseRef.observeSingleEvent(of: .value, with: { snapshot in
//            
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            
//            if let photoURL = postDict["photoURL"] {
//                completion(photoURL as? String)
//            }
//        }) {(error) in
//            print(error.localizedDescription)
//        }
//    }
//    
//    func uploadProfilePicture(_ image: UIImage, _ completion: @escaping((_ url:URL?) -> ())){
//        // get current user's userid
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        // get a reference to the storage object
//        let storage = Storage.storage().reference().child("user/\(uid)")
//        // image's must be saved as data object's so convert and compress the image
//        guard let image = imageView?.image, let imageData = UIImageJPEGRepresentation(image, 0.75) else {return}
//        // store the image
//        storage.putData(imageData, metadata: StorageMetadata()) { (metaData, error) in
//            if error == nil && metaData != nil {
//                storage.downloadURL { url, error in
//                    guard let downloadURL = url else { return }
//                    completion(downloadURL)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }

    
    
}

