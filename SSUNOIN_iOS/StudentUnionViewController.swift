//
//  StudentUnionViewController.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 27..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit
import Kingfisher

class StudentUnionViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UnionCellDelegate {
    
    @IBOutlet weak var unionTableView: UITableView!
    var elements : [Union] =
        [Union.init(unionImage: UIImage(named: "inmun")!, unionName: "당신의 곁에 당신의 안에 INSIDE", unionLocation: "조만식기념관 325호", unionPhoneNumber: "02-820-0872", unionFacebookLink: "https://www.facebook.com/soongsilinmun/?fref=ts"),
         Union.init(unionImage: UIImage(named: "korlan")!, unionName: "국어국문학과 학생회 동화국문", unionLocation: "조만식기념관 301호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/413890638693677/"),
         Union.init(unionImage: UIImage(named: "japan_s")!, unionName: "일어일문학과 학생회", unionLocation: "조만식기념관 320호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/groups/405208589512679/?fref=ts"),
         Union.init(unionImage: UIImage(named: "eng_s")!, unionName: "영어영문학과 학생회", unionLocation: "조만식기념관 324호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/ssueng/?fref=ts"),
         Union.init(unionImage: UIImage(named: "red_logo")!, unionName: "불어불문학과 학생회", unionLocation: "조만식기념관 317호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/groups/140462579404684/?fref=ts"),
         Union.init(unionImage: UIImage(named: "red_logo")!, unionName: "독어독문학과 학생회", unionLocation: "조만식기념관 318호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/groups/ssugermanistik/?fref=ts"),
         Union.init(unionImage: UIImage(named: "red_logo")!, unionName: "중어중문학과 학생회", unionLocation: "조만식기념관 302호", unionPhoneNumber: "none", unionFacebookLink: "none"),
         Union.init(unionImage: UIImage(named: "red_logo")!, unionName: "철학과 학생회", unionLocation: "조만식기념관 322호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/groups/1421115394862318/?fref=ts"),
         Union.init(unionImage: UIImage(named: "red_logo")!, unionName: "사학과 학생회", unionLocation: "조만식기념관 319호", unionPhoneNumber: "none", unionFacebookLink: "https://www.facebook.com/profile.php?id=100003766070033&fref=ts")]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        self.unionTableView.delegate = self
        self.unionTableView.dataSource = self
        self.unionTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnionCell", for: indexPath) as! UnionCell
        
        if elements.count > 0 {
            cell.unionImage.image = elements[indexPath.row].getUnionImage()
            cell.unionName.text = elements[indexPath.row].getUnionName()
            cell.unionLocation.text = elements[indexPath.row].getUnionLocation()
            
            cell.unionImage.layer.borderWidth = 0.5
            cell.unionImage.layer.masksToBounds = false
            cell.unionImage.layer.cornerRadius = cell.unionImage.frame.height/2
            cell.unionImage.clipsToBounds = true
            
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            
            cell.index = indexPath.row
            
            if elements[indexPath.row].getFacebookLink() == "none" {
                cell.facebookButtonItem.isHidden = true
            } else {
                cell.facebookButtonItem.isHidden = false
            }
            
            if elements[indexPath.row].getPhoneNumber() == "none" {
                cell.callButtonItem.isHidden = true
            } else {
                cell.callButtonItem.isHidden = false
            }
            
            let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 110))
            whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 3.0
            whiteRoundedView.layer.shadowOffset = CGSize(width: -0.1, height: 0.1)
            whiteRoundedView.layer.shadowOpacity = 0.2
            
            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubview(toBack: whiteRoundedView)
        }
        return cell
    }
    
    func callToUnion(index: Int) {
        let result_phone = self.elements[index].getPhoneNumber().replace(target: "-", withString: "")
        //UIApplication.shared.open(URL(string: result_phone)!, options: [:], completionHandler: nil)
        
        guard let number = URL(string: "tel://" + result_phone) else { return }
        UIApplication.shared.open(number)
    }
    
    func openFacebookPage(index: Int) {
        if let url = URL(string: self.elements[index].getFacebookLink()) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
