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

class NoticeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var majorName : String?
    var majorIndex = 0
    
    var noticeURL : [String] = [AppDataCache.korlanURL, AppDataCache.japaneseURL, AppDataCache.engURL, AppDataCache.frenchURL, AppDataCache.germanURL, AppDataCache.chineseURL, AppDataCache.phillosophyURL, AppDataCache.historyURL]
    
    @IBOutlet weak var tableView: UITableView!
    var elements : [Notice] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        self.title = self.majorName
        
        // Page Value : Initial Value is 1
        getHTMLDataFromURL(page: 1)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeCell
        
        cell.titleText.text = elements[indexPath.row].getTitle()
        cell.dateText.text = elements[indexPath.row].getDate()
        
        if elements[indexPath.row].getIsAttachment() {
            cell.attachmentIcon.image = UIImage(named: "attachmennt")
            //cell.attachmentIcon.isUserInteractionEnabled = true
        } else {
            cell.attachmentIcon.image = .none
            //cell.attachmentIcon.isUserInteractionEnabled = false
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func getHTMLDataFromURL(page: Int) {
        Alamofire.request(noticeURL[majorIndex] + "\(page)").responseString { response in
            let html = response.result.value
            if let doc = HTML(html: html!, encoding: .utf8) {
                for show in doc.css("table[class^='bbs-list']") {
                    for body in show.css("tbody") {
                        for tr in body.css("tr") {
                            var title: String?
                            var date: String?
                            var itemNo: Int = 0
                            var viewCount: Int = 0
                            var writer : String?
                            var attachment: Bool = false
                            var index = 1
                            
                            for td in tr.css("td") {
                                let showString = td.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                showString.replace(target: "\n", withString: "")
                                
                                if index == 1 {
                                    itemNo = (showString as NSString).integerValue
                                    print("\(itemNo)")
                                } else if index == 2 {
                                    title = showString
                                    print(title!)
                                } else if index == 3 {
                                    for img in tr.css("img") {
                                        // img["src"]!
                                        attachment = true
                                        print(attachment)
                                    }
                                } else if index == 4 {
                                    writer = showString
                                    print(showString)
                                } else if index == 5 {
                                    date = showString
                                    print(date!)
                                } else if index == 6 {
                                    viewCount = (showString as NSString).integerValue
                                    print("\(viewCount)")
                                }
                                
                                index += 1
                            }
                            
                            //init(itemNo : Int, title: String, date: String, isAttachment: Bool, viewCount : Int)
                            self.elements.append(Notice.init(itemNo: itemNo, title: title!, date: date!, isAttachment: attachment, viewCount: viewCount))
                        }
                    }
                }
                
                for item in doc.css("table, bbs-list") {
                    for tbls in doc.xpath("//td[3]//img") {
                        //print(tbls.text!)
                    }
                    //print(item.text!)
                }
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
}
