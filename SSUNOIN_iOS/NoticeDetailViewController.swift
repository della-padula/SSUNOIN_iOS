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

class NoticeDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var itemTitle : String?
    var itemDate : String?
    var itemLinkURL : String?
    
    
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var attachmentCount: UILabel!
    @IBOutlet weak var noticeContent: UIWebView!
    @IBOutlet weak var attachmentTableView: UITableView!
    @IBOutlet weak var attachmentTableViewHeightConstraint: NSLayoutConstraint!
    
    var elements : [Attachment] = []
    
    override func viewDidLoad() {
        self.title = "공지사항"
        titleText.text = itemTitle
        dateText.text = itemDate
        
        self.attachmentTableView.delegate = self
        self.attachmentTableView.separatorStyle = .none
        self.noticeContent.scrollView.bounces = false
        getNoticeContent()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentCell", for: indexPath) as! AttachmentCell
        
        if elements.count > 0 {
            cell.fileNameText.text = elements[indexPath.row].getFileName()
            cell.downloadLink = elements[indexPath.row].getDownloadLink()
        }
        
        return cell
    }
    
    func getNoticeContent() {
        Alamofire.request(itemLinkURL!).responseString {
            response in
            let html = response.result.value
            if let doc = HTML(html: html!, encoding: .utf8) {
                for show in doc.css("table[class|='bbs-view']") {
                    //print(show.text!)
                    self.attachmentCount.text="첨부파일 : \(show.css("a").count)개"
                    
                    if show.css("a").count < 1 {
                        self.attachmentTableViewHeightConstraint.constant = 0
                    }
                    
                    for ahref in show.css("a") {
                        print(ahref["href"]!)
                        print(ahref.text!)
                        
                        self.elements.append(Attachment.init(fileName: ahref.text!, downloadLink: ahref["href"]))
                    }
                }
                
                print("----")
                
                for show in doc.css("table[class^='bbs-body']") {
                    
                    for div in show.css("div") {
                        print(div.innerHTML!)
                        
                        self.noticeContent.loadHTMLString(div.innerHTML!, baseURL: nil)
                    }
                }
                
                self.attachmentTableView.dataSource = self
                self.attachmentTableView.reloadData()
            }
        }
    }
}
