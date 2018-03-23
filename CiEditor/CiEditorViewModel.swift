//
//  CiEditorViewModel.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/20.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorViewModel: NSObject {

    var editorType: CiEditorType = ciEditorTypePostTopic
    var postModel: CiEditorModel = CiEditorModel()
    
    override init() {
        super.init()
    }
    
}

extension CiEditorViewModel {
   
    /// 检测是否可以发送
    func checkSendCondition() -> Bool {
        switch editorType {
        case ciEditorTypePostTopic:
            let tmpTitle = postModel.titleString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines )
            let tmpContent = postModel.contentString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return ( (tmpTitle.lengthOfBytes(using: String.Encoding.utf8) >= 4) && (tmpContent.lengthOfBytes(using: String.Encoding.utf8) >= 1))
        default:
            let tmpContent = postModel.contentString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return (tmpContent.lengthOfBytes(using: String.Encoding.utf8) >= 1)
        }
    }
    
    /// 文本内容缓存
    func storeTextToLocal() {
        let tmpPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first?.appending("OnePostTopic.plist")
        if FileManager.default.fileExists(atPath: tmpPath!) == true {
            try! FileManager.default.removeItem(atPath: tmpPath!)
        }
        let tmpDict: NSMutableDictionary = ["content": postModel.contentString]
        if editorType == ciEditorTypePostTopic {
            tmpDict["title"] = postModel.titleString
        }
        tmpDict.write(toFile: tmpPath!, atomically: true)
    }
    
    
}
