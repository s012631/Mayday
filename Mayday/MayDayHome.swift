//
//  MayDayHome.swift
//  Mayday
//
//  Created by Itay Baror (student LM) on 2/13/19.
//  Copyright © 2019 Gabriel Hummel (student LM). All rights reserved.
//

import UIKit
import Foundation
class MayDayHome: UIViewController {
    
    @IBOutlet weak var gradSafe: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackgroundColor()
    }
    
    func animateBackgroundColor(){
        UIView.animate(withDuration: 10, delay: 0, options:[.autoreverse, .curveLinear, .repeat], animations: {
            let x = -(self.gradSafe.frame.width - self.view.frame.width)
            self.gradSafe.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
   
}

