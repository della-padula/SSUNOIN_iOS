//
//  NoticeDetailViewController.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 27..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit
import Kanna
import Alamofire

class NoticeDetailViewController : UIViewController {
    var itemTitle : String?
    var itemDate : String?
    var itemLinkURL : String?
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var attachmentCount: UILabel!
    @IBOutlet weak var noticeContent: UIWebView!
    @IBOutlet weak var attachmentTableView: UITableView!
    
    override func viewDidLoad() {
        self.title = "공지사항"
        titleText.text = itemTitle
        dateText.text = itemDate
        getNoticeContent()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func getNoticeContent() {
        Alamofire.request(itemLinkURL!).responseString {
            response in
            let html = response.result.value
            if let doc = HTML(html: html!, encoding: .utf8) {
                for show in doc.css("table[class|='bbs-view']") {
                    //print(show.text!)
                    self.attachmentCount.text="첨부파일 : \(show.css("a").count)개"
                    
                    for ahref in show.css("a") {
                        print(ahref["href"]!)
                    }
                }
                
                print("----")
                
                for show in doc.css("table[class^='bbs-body']") {
                    
                    for div in show.css("div") {
                        print(div.innerHTML!)
                        self.noticeContent.loadHTMLString(div.innerHTML!, baseURL: nil)
                        //print(show.text!)
                    }
                }
            }
        }
    }
}
