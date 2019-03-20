//
//  MayDayHome.swift
//  Mayday
//
//  Created by Itay Baror (student LM) on 2/13/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
class MayDayHome: UIViewController {
    
    //Outlet to hide and unhide the cancel button
    @IBOutlet weak var cancelButtonLabel: UIButton!
    //Countdown Variables
    @IBOutlet weak var maydayButtonLabel: UIButton!
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
        maydayButtonLabel.isHidden=false
        countDownLabel.isHidden=true
        cancelButtonLabel.isHidden=true
        setUpImageView()
        
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
            isPressed = false
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
}

