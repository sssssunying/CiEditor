//
//  CiBaseButton.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2018/3/22.
//  Copyright © 2018年 孙荧. All rights reserved.
//

import UIKit

/// 生成常用 Button 控件
/// 单个图片 generateButton(imageName: )
class CiBaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateButton(imageName: String) {
        setImage(UIImage(named: imageName + "_unselected"), for: .normal)
        setImage(UIImage(named: imageName + "_selected"), for: .selected)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
