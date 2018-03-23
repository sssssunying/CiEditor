//
//  CiZanModel.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2017/10/21.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit

class CiZanModel: NSObject {

    var normalTitle: String = LANG(key: "zan")
    var selectedTitle: String = "0"
    var normalImage: UIImage = UIImage.init(named: "todaytipdetailheaderbottomview_zan")!
    var selectedImage: UIImage = UIImage.init(named: "todaytipdetailheaderbottomview_zaned")!
    var normalColor: UIColor = BLACKLIGHTCOLOR
    var selectedColor: UIColor = GREENMAINCOLOR
    
    
    var zanType: CiZanType = CiZanType.zanFood
    var zanId: String = "1"
    
    
    
}
