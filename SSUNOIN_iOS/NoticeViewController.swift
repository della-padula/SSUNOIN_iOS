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

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

class NoticeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var majorName : String?
    var majorIndex = 0
    
    var loadMoreFlag = false
    
    var refreshControl: UIRefreshControl!
    var page = 1
    
    var loadingView: UIView = UIView()
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var spinner2 = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var noticeURL : [String] = [AppDataCache.korlanURL, AppDataCache.japaneseURL, AppDataCache.engURL, AppDataCache.frenchURL, AppDataCache.germanURL, AppDataCache.chineseURL, AppDataCache.phillosophyURL, AppDataCache.historyURL]
    
    @IBOutlet weak var tableView: UITableView!
    var elements : [Notice] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        self.showActivityIndicator()
        refreshControl = UIRefreshControl()
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(NoticeViewController.refresh(sender:)), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        self.title = self.majorName
        elements.removeAll()
        
        // Page Value : Initial Value is 1
        getHTMLDataFromURL(page: 1, majorIndex: majorIndex)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func refresh(sender: AnyObject) {
        print("새로 고침")
        page = 1
        elements.removeAll()
        self.tableView.beginUpdates()
        getHTMLDataFromURL(page: page, majorIndex: majorIndex)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.elements.count - 5
        let lastRowIndex = lastElement
        
        if indexPath.row == lastRowIndex {
            if (loadMoreFlag) {
                spinner2.startAnimating()
                spinner2.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tableView.tableFooterView = spinner2
                self.tableView.tableFooterView?.isHidden = false
                
                print("Load More")
                
                
                page = page + 1
                getHTMLDataFromURL(page: page, majorIndex: majorIndex)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row : \(indexPath.row)")
        
        guard let nextView = self.storyboard?.instantiateViewController(withIdentifier: "NoticeDetailVC") as? NoticeDetailViewController else {
            return
        }
        nextView.itemTitle = elements[indexPath.row].getTitle()
        nextView.itemDate = elements[indexPath.row].getDate()
        nextView.itemLinkURL = elements[indexPath.row].getLinkURL()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeCell
        
        if elements.count > 0 {
            cell.titleText.text = elements[indexPath.row].getTitle()
            cell.dateText.text = elements[indexPath.row].getDate()
            
            if elements[indexPath.row].getIsAttachment() {
                cell.attachmentIcon.image = UIImage(named: "attachmennt")
            } else {
                cell.attachmentIcon.image = .none
            }
            
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func getHTMLDataFromURL(page: Int, majorIndex: Int) {
        Alamofire.request(noticeURL[majorIndex] + "\(page)").responseString { response in
            let html = response.result.value
            if html != nil {
                if let doc = HTML(html: html!, encoding: .utf8) {
                    for show in doc.css("table[class^='bbs-list']") {
                        for body in show.css("tbody") {
                            if body.css("tr").count < 10 {
                                self.loadMoreFlag = false;
                            } else {
                                self.loadMoreFlag = true;
                            }
                            
                            for tr in body.css("tr") {
                                var title: String?
                                var date: String?
                                var itemNo: Int = 0
                                var viewCount: Int = 0
                                //var writer : String?
                                var linkURL : String?
                                var attachment: Bool = false
                                var index = 1
                                
                                //print("BODY CLASS : \(tr["class"])")
                                if tr["class"] != "trNotice" {
                                    for td in tr.css("td") {
                                        let showString = td.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                        showString.replace(target: "\n", withString: "")
                                        //print(showString)
                                        
                                        if index == 1 {
                                            if(majorIndex == 4) {
                                                title = showString
                                                for ahref in td.css("a") {
                                                    //print(ahref["href"]!)
                                                    linkURL = ahref["href"]!
                                                }
                                                
                                                //print(title)
                                            } else {
                                                itemNo = (showString as NSString).integerValue
                                            }
                                            //print("\(itemNo)")
                                        } else if index == 2 {
                                            if(majorIndex == 4) {
                                                date = showString
                                                //print(date)
                                            } else {
                                                title = showString
                                            }
                                            //print(title!)
                                            
                                            for ahref in td.css("a") {
                                                //print(ahref["href"]!)
                                                linkURL = ahref["href"]!
                                            }
                                        } else if index == 3 {
                                            if(majorIndex == 4) {
                                                viewCount = (showString as NSString).integerValue
                                                //print("\(viewCount)")
                                            } else {
                                                for _ in tr.css("img[alt^='첨부 파일']") {
                                                    // img["src"]!
                                                    attachment = true
                                                    //print(attachment)
                                                }
                                            }
                                        } else if index == 4 {
                                            //writer = showString
                                            //print(showString)
                                            if(majorIndex == 3 || majorIndex == 5) {
                                                date = showString
                                            }
                                        } else if index == 5 {
                                            if(majorIndex != 3 && majorIndex != 5) {
                                                date = showString
                                            }
                                            //print(date!)
                                        } else if index == 6 {
                                            viewCount = (showString as NSString).integerValue
                                            //print("\(viewCount)")
                                        }
                                        
                                        index += 1
                                    }
                                    //print("after for")
                                    self.elements.append(Notice.init(itemNo: itemNo, title: title!, linkURL: linkURL!, date: date!, isAttachment: attachment, viewCount: viewCount))
                                }
                            }
                        }
                    }
                }
            } else {
                print("Network Error")
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.spinner2.stopAnimating()
            
            self.tableView.reloadData()
            self.tableView.endUpdates()
            
            self.refreshControl.endRefreshing()
            self.hideActivityIndicator()
        }
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(hex: "FFFFFF")
            self.loadingView.alpha = 1.0
            self.loadingView.clipsToBounds = true
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
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
