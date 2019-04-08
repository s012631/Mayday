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
    @IBOutlet weak var safetyReleaseTextField: UITextField!
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    
    var finalCode = ""
    
    //tells if button has been pressed in order to determine which background to use
    var isPressed = false
    
    //BG Variables
    let imageView = UIImageView()
    var horizontalConstraintMove : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendSMS()
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        cancelButtonLabel.isHidden=true
        safetyReleaseTextField.isHidden=true
        setUpImageView()
        print(finalCode + ">>>>")
        print("didload")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackgroundColor()
    }
    
    @IBAction func MayDayButton(_ sender: UIButton) {
        isPressed = true
        //swap visible labels
        maydayButtonLabel.isHidden=true
        countDownLabel.isHidden=false
        cancelButtonLabel.isHidden=false
        //Begin Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
            safetyReleaseTextField.keyboardType = UIKeyboardType.numberPad
            isPressed = false
            endTimer()
            // If safety release text equals the safety release code from settings page, reset Mayday
            print(finalCode)
            if safetyReleaseTextField.text == finalCode{
             //   resetMayday()
                print(finalCode)
            }
        }
    }
    
    func resetMayday(){
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        cancelButtonLabel.isHidden=true
        safetyReleaseTextField.isHidden=true
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
    func sendSMS(){
        let accountSID = "ACc3a05fd5f0c779f27346d34b22e4a730"
        let authToken = "06347b68f614f8f0540db1a9e1793b0c"
        let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
        let parameters = ["From": "+12673607440", "To": "+16109553378", "Body": "Mayday: Your friend Andrew is in Danger!"]
        print("sms processsssssssssssssssss")
        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: accountSID, password: authToken)
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
}



