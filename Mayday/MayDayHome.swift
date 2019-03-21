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
    
    @IBOutlet weak var MayDayButton: UIButton!
    //Countdown Variables
    @IBOutlet weak var countDownLabel: UILabel!
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    
    //tells if button has been pressed in order to determine which background to use
    var isPressed = false
    
    //BG Variables
    let imageView = UIImageView()
    var horizontalConstraintMove : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendSMS()
        setUpImageView()
        
        print("didload")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackgroundColor()
    }
    
    @IBAction func MayDayButton(_ sender: UIButton) {
        isPressed = true
        
        viewDidLoad()
        setUpImageView()
        //Begin Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        MayDayButton.isHidden = true
        
    }
    
    
    //CountDown Methods
    @objc func updateTimer() {
        countDownLabel.text = "\(timeFormatted(seconds))"
        
        if seconds != 0 {
            seconds -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "%01d", seconds)
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
    func sendSMS(){
        let accountSID = "ACc3a05fd5f0c779f27346d34b22e4a730"
        let authToken = "06347b68f614f8f0540db1a9e1793b0c"
        //        if let accountSID = ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"],
        //            let authToken = ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"] {
        
        
        let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
        let parameters = ["From": "+12673607440", "To": "+16109553378", "Body": "Hello from Swift!"]
        
        Alamofire.request(url, method: .post, parameters: parameters)
            .authenticate(user: accountSID, password: authToken)
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
}



