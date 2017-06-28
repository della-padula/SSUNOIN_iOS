//
//  Union.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 28..
//  Copyright © 2017년 Personal. All rights reserved.
//

import Foundation
import UIKit

class Union {
    var unionImage: UIImage?
    var unionName: String?
    var unionLocation: String?
    var unionPhoneNumber : String?
    var unionFacebookLink : String?
    
    init(unionImage: UIImage, unionName: String, unionLocation: String, unionPhoneNumber: String, unionFacebookLink: String) {
        self.unionImage = unionImage
        self.unionName = unionName
        self.unionLocation = unionLocation
        self.unionPhoneNumber = unionPhoneNumber
        self.unionFacebookLink = unionFacebookLink
    }
    
    func getUnionImage() -> UIImage {
        return self.unionImage!
    }
    
    func getUnionName() -> String {
        return self.unionName!
    }
    
    func getUnionLocation() -> String {
        return self.unionLocation!
    }
    
    func getPhoneNumber() -> String {
        return self.unionPhoneNumber!
    }
    
    func getFacebookLink() -> String {
        return self.unionFacebookLink!
    }
}
