//
//  AttachmentCell.swift
//  SSUNOIN_iOS
//
//  Created by 김태인 on 2017. 6. 28..
//  Copyright © 2017년 Personal. All rights reserved.
//

import UIKit
import Alamofire

protocol AttachmentDelegate : class {
    func showDocumentInteractionController(filePath: String)
    func showIndicator()
}

class AttachmentCell : UITableViewCell {
    
    weak var cellDelegate : AttachmentDelegate?
    var downloadLink : String?
    var fileName : String?
    
    var docController: UIDocumentInteractionController!
    
    @IBOutlet weak var fileNameText: UILabel!
    @IBAction func downloadButton(_ sender: Any) {
        self.cellDelegate?.showIndicator()
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(self.fileName!)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(downloadLink!, to: destination).response { response in
            if response.error == nil, let filePath = response.destinationURL?.path {
                print("Downloaded File Path : " + filePath)
                self.cellDelegate?.showDocumentInteractionController(filePath: filePath)
            }
        }
    }
}
