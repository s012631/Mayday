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
        countDownLabel.isHidden = false
        
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
        imageView.image = #imageLiteral(resourceName: "gradSafe.png")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        horizontalConstraintMove = imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        horizontalConstraintMove?.isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 1250).isActive = true
        view.sendSubviewToBack(imageView)
        
        
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
        if let accountSID = ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"]{
            print(accountSID)
        }
        else{
        print("SID not found")
        }
//            let authToken = ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"] {
//
//            let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
//            let parameters = ["From": "+12673607440", "To": "+16109553378", "Body": "Hello from Swift!"]
//
//            AF.request(url, method: .post, parameters: parameters)
//                .authenticate(user: accountSID, password: authToken)
//                .responseJSON { response in
//                    debugPrint(response)
//            }
//        }
//
//        RunLoop.main.run()
        }
    
}

