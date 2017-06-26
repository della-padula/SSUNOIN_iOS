//
//  NoticeViewController.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 26..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit

class NoticeViewController : UIViewController {
    @IBAction func backButton(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
