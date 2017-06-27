//
//  ViewController.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 26..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var MajorTableView: UITableView!
    
    var majorList : [Major] =
        [Major.init(majorName: "국어국문학과", majorEnglishName: "Korean Language & Literature"),
         Major.init(majorName: "일어일문학과", majorEnglishName: "Japanese Language & Literature"),
         Major.init(majorName: "영어영문학과", majorEnglishName: "English Language & Literature"),
         Major.init(majorName: "불어불문학과", majorEnglishName: "French Language & Literature"),
         Major.init(majorName: "독어독문학과", majorEnglishName: "German Language & Literature"),
         Major.init(majorName: "중어중문학과", majorEnglishName: "Chinese Language & Literature"),
         Major.init(majorName: "철학과", majorEnglishName: "Department of Philosophy"),
         Major.init(majorName: "사학과", majorEnglishName: "Department of History")]
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MajorTableView.delegate = self
        self.MajorTableView.dataSource = self
        
        self.MajorTableView.rowHeight = UITableViewAutomaticDimension
        self.MajorTableView.estimatedRowHeight = 140
        self.MajorTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let nextView = self.storyboard?.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeViewController else {
            return
        }
        
        nextView.majorName = self.majorList[indexPath.row].getName()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MajorCell", for: indexPath) as! MajorCell
        
        cell.MajorName.text = majorList[indexPath.row].getName()
        cell.MajorEngName.text = majorList[indexPath.row].getEnglishName()
        
        cell.selectionStyle = .none
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 80))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -0.1, height: 0.1)
        whiteRoundedView.layer.shadowOpacity = 0.08
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        return cell
    }
    
}

