//
//  Attachment.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 28..
//  Copyright © 2017년 Personal. All rights reserved.
//

import Foundation

class Attachment {
    var fileName : String?
    var downloadLink : String?
    
    init(fileName: String?, downloadLink: String?) {
        self.fileName = fileName
        self.downloadLink = downloadLink
    }
    
    func getFileName() -> String {
        return self.fileName!
    }
    
    func getDownloadLink() -> String {
        return self.downloadLink!
    }
}
