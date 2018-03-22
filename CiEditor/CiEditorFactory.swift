//
//  CiEditorFactory.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/22.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

typealias CiEditorType = String
var ciEditorReplyViewTypeAll: CiEditorType = "ciEditorReplyViewTypeAll"
var ciEditorReplyViewTypeTodayNotice: CiEditorType = "ciEditorReplyViewTypeTodayNotice"
var ciEditorReplyViewTypeMamaTopic: CiEditorType = "ciEditorReplyViewTypeMamaTopic"

class CiEditorFactory: NSObject {

    class func createEditor( editorType: CiEditorType) -> SBaseViewController {
        let vc = CiEditorReplyViewViewController()
        vc.generateReplyView(replyType: editorType)
        return vc
    }
    
    
}
