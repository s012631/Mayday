//
//  Settings.swift
//  Mayday
//
//  Created by Theodore Henry (student LM) on 4/3/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class Settings{
    
    var nameRef: String?
    var contact1Ref: String?
    var contact2Ref: String?
    var contact3Ref: String?
    var alarmRef: String?
    var phone1Ref: String?
    var phone2Ref: String?
    var phone3Ref: String?
    var safetyCodeRef: String?
    
    init(){
//        getUserInfo() { userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode in
//        self.nameRef = userName
//        self.contact1Ref = contact1
//        self.contact2Ref = contact2
//        self.contact3Ref = contact3
//        self.phone1Ref = phone1
//        self.phone2Ref = phone2
//        self.phone3Ref = phone3
//        self.alarmRef = alarm
//        self.safetyCodeRef = safetyCode
//        }
    }
    
//    var nameRef: String?
//    var contact1Ref: String?
//    var contact2Ref: String?
//    var contact3Ref: String?
//    var alarmRef: String?
//    var phone1Ref: String?
//    var phone2Ref: String?
//    var phone3Ref: String?
//    var safetyCodeRef: String?
    
    
    func getInfo(){
        getUserInfo() { userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode in
        self.nameRef = userName
        self.contact1Ref = contact1
        self.contact2Ref = contact2
        self.contact3Ref = contact3
        self.phone1Ref = phone1
        self.phone2Ref = phone2
        self.phone3Ref = phone3
        self.alarmRef = alarm
        self.safetyCodeRef = safetyCode
        }
    }
    
    func getUserInfo(_ completion: @escaping((_ name:String?, _ contact1: String?, _ contact2: String?, _ contact3: String?, _ alarm: String?, _ phone1: String?, _ phone2: String?, _ phone3: String?, _ safetyCode: String?)  -> ())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("user/\(uid)")
        
        databaseRef.observeSingleEvent(of: .value, with: { snapshot  in
            let dictionary = snapshot.value as? [String : AnyObject] ?? [:]
            
            if let name = dictionary["Name"] {
                self.nameRef = name as? String
            }
            if let eContact1 = dictionary["EmergencyContact1"]{
                self.contact1Ref = eContact1 as? String
            }
            if let eContact2 = dictionary["EmergencyContact2"]{
                self.contact2Ref = eContact2 as? String
            }
            if let eContact3 = dictionary["EmergencyContact3"]{
                self.contact3Ref = eContact3 as? String
            }
            if let alarmCompany = dictionary["Alarm"]{
                self.alarmRef = alarmCompany as? String
            }
            if let firstPhone = dictionary["Phone1"]{
                self.phone1Ref = firstPhone as? String
            }
            if let secondPhone = dictionary["Phone2"]{
                self.phone2Ref = secondPhone as? String
            }
            if let thirdPhone = dictionary["Phone3"]{
                self.phone3Ref = thirdPhone as? String
            }
            if let safeCode = dictionary["Code"]{
                self.safetyCodeRef = safeCode as? String
            }
            
            completion(self.nameRef, self.contact1Ref, self.contact2Ref, self.contact3Ref, self.alarmRef, self.phone1Ref, self.phone2Ref, self.phone3Ref, self.safetyCodeRef)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
 //   func getInfo(){
//        getUserInfo() { userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode in
//        self.nameRef = userName
//        self.contact1Ref = contact1
//        self.contact2Ref = contact2
//        self.contact3Ref = contact3
//        self.phone1Ref = phone1
//        self.phone2Ref = phone2
//        self.phone3Ref = phone3
//        self.alarmRef = alarm
//        self.safetyCodeRef = safetyCode
//        }
 //   }
}
