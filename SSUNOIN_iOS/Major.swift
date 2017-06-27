//
//  Major.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 26..
//  Copyright © 2017년 Personal. All rights reserved.
//

import Foundation

class Major {
    var majorName : String?
    var majorEnglishName : String?
    
    init(majorName : String, majorEnglishName : String) {
        self.majorName = majorName
        self.majorEnglishName = majorEnglishName
    }
    
    func getName() -> String {
        return self.majorName!
    }
    
    func getEnglishName() -> String {
        return self.majorEnglishName!
    }
}
