//
//  CiEditorFactory.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/22.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

//enum CiEditorType: String {
//    case ciEditorReplyViewTypeAll = "ciEditorReplyViewTypeAll"
//    case ciEditorReplyViewTypeTodayNotice = "ciEditorReplyViewTypeTodayNotice"
//    case ciEditorReplyViewTypeMamaTopic = "ciEditorReplyViewTypeMamaTopic"
//    case ciEidtorTypePostTopic = "ciEidtorTypePostTopic"
//    case ciEditorTypeWriteDiary = "ciEditorTypeWriteDiary"
//}

typealias CiEditorType = String
var ciEditorReplyViewTypeAll = "ciEditorReplyViewTypeAll"
var ciEditorReplyViewTypeTodayNotice = "ciEditorReplyViewTypeTodayNotice"
var ciEditorReplyViewTypeMamaTopic = "ciEditorReplyViewTypeMamaTopic"
var ciEditorTypePostTopic = "ciEidtorTypePostTopic"
var ciEditorTypeWriteDiary = "ciEditorTypeWriteDiary"


class CiEditorFactory: NSObject {

    class func createEditor( editorType: CiEditorType) -> UIViewController {
        if editorType == ciEditorTypePostTopic || editorType == ciEditorTypeWriteDiary {
            let vc = CiEditorViewController()
            let nav = UINavigationController()
            nav.navigationBar.tintColor = .black
            nav.navigationBar.backgroundColor = .white
            nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black ,NSAttributedStringKey.font: MEDIUMFONT18 as Any]
            nav.pushViewController(vc, animated: false)
            vc.viewModel.editorType = editorType
            vc.generateView()
            return nav
        }
        let vc = CiEditorReplyViewViewController()
        vc.viewModel.editorType = editorType
        vc.generateReplyView()
        return vc
    }
    
}
