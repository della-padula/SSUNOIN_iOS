//
//  Notice.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 27..
//  Copyright © 2017년 Personal. All rights reserved.
//

import Foundation

class Notice {
    var itemNo : Int
    var title : String?
    var date : String?
    var isAttachment : Bool
    var viewCount : Int
    
    
    init(itemNo : Int, title: String, date: String, viewCount : Int) {
        self.itemNo = itemNo
        self.title = title
        self.date = date
        self.isAttachment = false
        self.viewCount = viewCount
    }
    
    init(itemNo : Int, title: String, date: String, isAttachment: Bool, viewCount : Int) {
        self.itemNo = itemNo
        self.title = title
        self.date = date
        self.isAttachment = isAttachment
        self.viewCount = viewCount
    }
    
    func getTitle() -> String {
        return self.title!
    }
    
    func getDate() -> String {
        return self.date!
    }
    
    func getIsAttachment() -> Bool {
        return self.isAttachment
    }
}
