//
//  CiZan.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2017/11/21.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

public struct CiZan {
    
    var normalTitle: String = LANG(key: "zan")
    var normalImage: UIImage = UIImage.init(named: "todaytipdetailheaderbottomview_zan")!
    var selectedImage: UIImage = UIImage.init(named: "todaytipdetailheaderbottomview_zaned")!
    let normalColor: UIColor = BLACKLIGHTCOLOR
    let selectedColor: UIColor = GREENMAINCOLOR
    
    var zanType: CiZanType     = CiZanType.zanFood  // 点赞类型
    var zanId: String          = "0"                // 点赞ID
    var zanNum: Int            = 0                  // 点赞数
    var isZan: Bool            = false              // 是否点赞
    
    let zanTipStringArray: [String] = ["zan_tip_string_1",
                                       "zan_tip_string_2",
                                       "zan_tip_string_3",
                                       "zan_tip_string_4",
                                       "zan_tip_string_5",
                                       "zan_tip_string_6",
                                       "zan_tip_string_7",
                                       "zan_tip_string_8",
                                       "zan_tip_string_9",
                                       "zan_tip_string_10",
                                       "zan_tip_string_11",
                                       "zan_tip_string_12",
                                       "zan_tip_string_13",
                                       "zan_tip_string_14",
                                       "zan_tip_string_15"]
    
    var zanIndex: Int {
        return Int(arc4random_uniform(15))
    }
    
    var zanTipString: String {
        return LANG(key:(zanTipStringArray[zanIndex]))
    }
    
    var showTipString = ""
    
    init(zanType: CiZanType,
         zanId: String,
         zanNum: Int,
         isZan: Bool) {
        self.zanType       = zanType
        self.zanId         = zanId
        self.zanNum        = zanNum
        self.isZan         = isZan
    }
    
    init(map: Map) throws {
        zanId         = try map.value("id")
        zanType       = try map.value("type")
        zanNum        = try map.value("likeNum")
        isZan         = try map.value("isLike")
    }
    
    
}
