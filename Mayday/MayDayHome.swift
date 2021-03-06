//
//  MayDayHome.swift
//  Mayday
//
//  Created by Itay Baror (student LM) on 2/13/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
import Alamofire
class MayDayHome: UIViewController {
    
    //Outlet to hide and unhide the cancel button
    @IBOutlet weak var cancelButtonLabel: UIButton!
    //Countdown Variables
    @IBOutlet weak var maydayButtonLabel: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
 
    @IBOutlet weak var safteyReleaseLine: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var safetyReleaseTextField: UITextField!
    
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false

    
    var userInfo: Settings?
    
    var safetyReleaseCode = ""
    var username = ""
    var name1 = ""
    var name2 = ""
    var name3 = ""
    var number1 = ""
    var number2 = ""
    var number3 = ""
    
    //tells if button has been pressed in order to determine which background to use
    var isPressed = false
    
    //BG Variables
    let imageView = UIImageView()
    var horizontalConstraintMove : NSLayoutConstraint?
    
    let info = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        safteyReleaseLine.isHidden=true
        cancelButtonLabel.isHidden=true
        safetyReleaseTextField.isHidden=true
        setUpImageView()
        
        userInfo = Settings()
        userInfo?.getUserInfo({ (userName, contact1, contact2, contact3, alarm, phone1, phone2, phone3, safetyCode) in
            if let info = self.userInfo{
                print("Info gathering method*****************")
                if let code = info.safetyCodeRef{
                    self.safetyReleaseCode = code
                    print(code)
                }
                if let name = info.nameRef{
                    self.username = name
                    print(self.username)
                }
                if let name1 = info.contact1Ref{
                    self.name1 = name1
                    print(self.name1)
                }
                if let name2 = info.contact2Ref{
                    self.name2 = name2
                    print(self.name2)
                }
                if let name3 = info.contact3Ref{
                    self.name3 = name3
                    print(self.name3)
                }
                if let number1 = info.phone1Ref{
                    self.number1 = number1
                    print(self.number1)
                }
                if let number2 = info.phone2Ref{
                    self.number2 = number2
                    print(self.number2)
                }
                if let number3 = info.phone3Ref{
                    self.number3 = number3
                    print(self.number3)
                }
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackgroundColor()
    }
    
    @IBAction func MayDayButton(_ sender: UIButton) {
        if(isPressed == false){
        isPressed = true
        //swap visible labels
        maydayButtonLabel.isHidden=true
        countDownLabel.isHidden=false
        safteyReleaseLine.isHidden=true
        safetyReleaseTextField.isHidden=true
        cancelButtonLabel.isHidden=false
        //Begin Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    
    //CountDown Methods
    @objc func updateTimer() {
        countDownLabel.text = "\(timeFormatted(seconds))"
        
        if seconds != 0 {
            seconds -= 1
        } else {
            setUpImageView()
            maydayButtonLabel.isHidden=false
            countDownLabel.isHidden=true
            cancelButtonLabel.isHidden=true
            settingsButtonOutlet.isHidden=true
            safetyReleaseTextField.isHidden=false
            safteyReleaseLine.isHidden=false

            safetyReleaseTextField.keyboardType = UIKeyboardType.numberPad
            endTimer()
            sendSMS1()
            sendSMS2()
            sendSMS3()
            // If safety release text equals the safety release code from settings page, reset Mayday
            
           safetyReleaseTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
                
//            if safetyReleaseTextField.text == safetyReleaseCode{
//                resetMayday()
          //      viewDidLoad()
                
        //    }
        }
    }

    @objc func textFieldDidChange(textField: UITextField){
        if safetyReleaseTextField.text == safetyReleaseCode{
            resetMayday()
            print("Text is equal")
        }
    }

    func resetMayday(){
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        cancelButtonLabel.isHidden=true
        safetyReleaseTextField.isHidden=true
        safteyReleaseLine.isHidden=true
        settingsButtonOutlet.isHidden=false
        isPressed = false
        setUpImageView()
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "%01d", seconds)
    }
    
    //When pressed the countdown will stop and the background will switch back to the default, seconds reset and timer is invalidated
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        cancelButtonLabel.isHidden=true
        endTimer()
        seconds = 5
        countDownLabel.text = "\(timeFormatted(seconds))"
        isPressed = false
        setUpImageView()
        
    }
    
    //Sets up background image
    func setUpImageView(){
        view.addSubview(imageView)
        
        if(isPressed == false){
        imageView.image = #imageLiteral(resourceName: "gradSafe.png")
       
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        horizontalConstraintMove = imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        horizontalConstraintMove?.isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 1250).isActive = true
        view.sendSubviewToBack(imageView)
        }
        else if(isPressed == true){
            imageView.image = UIImage(named: "gradDanger")
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            horizontalConstraintMove = imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
            horizontalConstraintMove?.isActive = true
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 1250).isActive = true
            view.sendSubviewToBack(imageView)
        }
        
      
    }

    //Background image animation left to right
    func animateBackgroundColor(){
        horizontalConstraintMove?.constant = -(self.imageView.frame.width - self.view.frame.width)
        UIView.animate(withDuration: 10, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
//Sends text currently practice
//How i did it: https://www.twilio.com/blog/2018/03/sending-text-messages-in-swift-with-twilio.html
//VVC9Fq6VK0zNesttfIKzl7iPzDqs3//ziiVNVswx
func sendSMS1(){
    let accountSID = "ACc3a05fd5f0c779f27346d34b22e4a730"
    let authToken = "06347b68f614f8f0540db1a9e1793b0c"
    let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
    let parameters = ["From": "+12673607440", "To": number1, "Body": "Mayday: \(name1), your friend \(username) is in danger! click the link to see where they are: https://www.google.com/maps/dir/40.010089,-75.2789172/301+E+Montgomery+Ave,+Ardmore,+PA+19003/@40.0106444,-75.282188,17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x89c6c09c631f0b51:0x6a39636a31f22e56!2m2!1d-75.2803529!2d40.0098854!3e2"]
    print("sms processsssssssssssssssss")
    print(number1)
    Alamofire.request(url, method: .post, parameters: parameters)
        .authenticate(user: accountSID, password: authToken)
        .responseJSON { response in
            debugPrint(response)
    }
}
func sendSMS2(){
    let accountSID = "ACc3a05fd5f0c779f27346d34b22e4a730"
    let authToken = "06347b68f614f8f0540db1a9e1793b0c"
    let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
    let parameters = ["From": "+12673607440", "To": number2, "Body": "Mayday: \(name2), your friend \(username) is in danger! click the link to see where they are: https://www.google.com/maps/dir/40.010089,-75.2789172/301+E+Montgomery+Ave,+Ardmore,+PA+19003/@40.0106444,-75.282188,17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x89c6c09c631f0b51:0x6a39636a31f22e56!2m2!1d-75.2803529!2d40.0098854!3e2"]
    print("sms processsssssssssssssssss")
    print(number1)
    Alamofire.request(url, method: .post, parameters: parameters)
        .authenticate(user: accountSID, password: authToken)
        .responseJSON { response in
            debugPrint(response)
    }
}
func sendSMS3(){
    let accountSID = "ACc3a05fd5f0c779f27346d34b22e4a730"
    let authToken = "06347b68f614f8f0540db1a9e1793b0c"
    let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
    let parameters = ["From": "+12673607440", "To": number3, "Body": "Mayday: \(name3), your friend \(username) is in danger! click the link to see where they are: https://www.google.com/maps/dir/40.010089,-75.2789172/301+E+Montgomery+Ave,+Ardmore,+PA+19003/@40.0106444,-75.282188,17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x89c6c09c631f0b51:0x6a39636a31f22e56!2m2!1d-75.2803529!2d40.0098854!3e2"]
    print("sms processsssssssssssssssss")
    print(number1)
    Alamofire.request(url, method: .post, parameters: parameters)
        .authenticate(user: accountSID, password: authToken)
        .responseJSON { response in
            debugPrint(response)
    }
}

}



