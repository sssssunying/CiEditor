//
//  HomeToolCell.swift
//  PregNotice
//
//  Created by 大大大大荧 on 2017/8/16.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import Stevia

class OneToolCell: UICollectionViewCell {
    
    lazy var showImageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 15, width: 43, height: 43))
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 90 - 30, width: SCREENWIDTH / 3, height: 16))
        label.textColor = BLACKLIGHTCOLOR
        label.font = FONT12
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showImageView.center = CGPoint.init(x: contentView.center.x, y: showImageView.center.y)
        contentView.addSubview(showImageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

