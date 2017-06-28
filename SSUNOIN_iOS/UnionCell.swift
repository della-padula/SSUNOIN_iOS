//
//  UnionCell.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 26..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit

protocol UnionCellDelegate : class {
    func callToUnion(index: Int)
    func openFacebookPage(index: Int)
}

class UnionCell : UITableViewCell {
    weak var cellDelegate : UnionCellDelegate?
    
    @IBOutlet weak var unionImage: UIImageView!
    @IBOutlet weak var unionName: UILabel!
    @IBOutlet weak var unionLocation: UILabel!
    @IBOutlet weak var callButtonItem: UIButton!
    @IBOutlet weak var facebookButtonItem: UIButton!
    
    var index : Int?
    
    @IBAction func callButton(_ sender: Any) {
        self.cellDelegate?.callToUnion(index: self.index!)
    }
    
    @IBAction func facebookButton(_ sender: Any) {
        self.cellDelegate?.openFacebookPage(index: self.index!)
    }
}
