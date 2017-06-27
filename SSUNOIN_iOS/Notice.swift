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
    var linkURL : String?
    
    init(itemNo : Int, title: String, linkURL: String, date: String, isAttachment: Bool, viewCount : Int) {
        self.itemNo = itemNo
        self.title = title
        self.linkURL = linkURL
        self.date = date
        self.isAttachment = isAttachment
        self.viewCount = viewCount
    }
    
    func getTitle() -> String {
        return self.title!
    }
    
    func getLinkURL() -> String {
        return self.linkURL!
    }
    
    func getDate() -> String {
        return self.date!
    }
    
    func getIsAttachment() -> Bool {
        return self.isAttachment
    }
}
