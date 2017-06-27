//
//  NoticeViewController.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 26..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit
import Kanna
import Alamofire

class NoticeViewController : UIViewController {
    
    var majorName : String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        self.title = self.majorName
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func getHTMLDataFromURL(url: String) {
        let apiURI = URL(string: "http://www.ddanzi.com/free")
        
        
    }
    
}
