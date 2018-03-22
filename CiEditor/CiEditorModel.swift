//
//  CiEditorModel.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/20.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

struct CiEditor {
    var postUrl: String
    var postParams: [String : Any]
    var callBack: CompleteBlockWithoutReturnWithAnyParameter
    
    init(url: String ,params: [String : Any], complete: @escaping CompleteBlockWithoutReturnWithAnyParameter) {
        self.postUrl = url
        self.postParams = params
        self.callBack = complete
    }
}

class CiEditorModel: NSObject {

}
