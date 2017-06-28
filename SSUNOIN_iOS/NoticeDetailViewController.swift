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

class NoticeDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate, AttachmentDelegate {
    var itemTitle : String?
    var itemDate : String?
    var itemLinkURL : String?
    
    var loadingView: UIView = UIView()
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var attachmentCount: UILabel!
    @IBOutlet weak var noticeContent: UIWebView!
    @IBOutlet weak var attachmentTableView: UITableView!
    @IBOutlet weak var attachmentTableViewHeightConstraint: NSLayoutConstraint!
    
    var elements : [Attachment] = []
    
    var docController: UIDocumentInteractionController!
    
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
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        self.docController = nil
    }
    
    func showDocumentInteractionController(filePath: String) {
        print("open file dialog")
        self.hideActivityIndicator()
        self.docController = UIDocumentInteractionController(url: NSURL(fileURLWithPath: filePath) as URL)
        self.docController.name = NSURL(fileURLWithPath: filePath).lastPathComponent
        print("NAME : " + self.docController.name!)
        self.docController.delegate = self
        self.docController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    
    func showIndicator() {
        self.showActivityIndicator()
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
            cell.fileName = elements[indexPath.row].getFileName()
            cell.selectionStyle = .none
            cell.cellDelegate = self
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
                    
                    if show.css("a").count > 0 {
                        self.attachmentTableViewHeightConstraint.constant = 90
                        
                        self.attachmentCount.text="첨부파일 : \(show.css("a").count)개"
                    } else {
                        self.attachmentCount.text="첨부파일 없음"
                    }
                    
                    for ahref in show.css("a") {
                        //print(ahref["href"]!)
                        //print(ahref.text!)
                        
                        self.elements.append(Attachment.init(fileName: ahref.text!, downloadLink: ahref["href"]))
                    }
                }
                
                print("----")
                
                for show in doc.css("table[class^='bbs-body']") {
                    
                    for div in show.css("div") {
                        //print(div.innerHTML!)
                        
                        self.noticeContent.loadHTMLString(div.innerHTML!, baseURL: nil)
                    }
                }
                
                self.attachmentTableView.dataSource = self
                self.attachmentTableView.reloadData()
            }
        }
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(hex: "303030")
            self.loadingView.alpha = 0.3
            self.loadingView.clipsToBounds = true
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
}
