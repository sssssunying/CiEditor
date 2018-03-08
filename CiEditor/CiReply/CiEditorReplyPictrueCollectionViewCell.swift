//
//  CiEditorReplyPictrueCollectionViewCell.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/7.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorReplyPictrueCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(btnCheck)
        
        sv(imageView, btnCheck)
        imageView.top(0).bottom(0).left(0).right(0)
        btnCheck.top(15).right(15).width(30).height(30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.frame = CGRect.init(x: 0, y: 0, width: 100, height: 214)
    }
    
    lazy var btnCheck: UIButton = UIButton().then {
        $0.frame                      = CGRect.init(x: SCREENWIDTH - 57, y: 0, width: 30, height: 30)
        $0.showsTouchWhenHighlighted  = true
        $0.setImage(UIImage(named: "selector_unchecked"), for: .normal)
        $0.setImage(UIImage(named:  "selector_checked"), for: .selected)
    }
    
    
}
