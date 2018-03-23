//
//  CiZanViewModel.swift
//  PregNotice
//
//  Created by sy on 2017/10/10.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import SwiftyJSON

enum CiZanType: Int {
    case zanArticle = 1
    case zanSymptom = 2
    case zanReceipt = 3
    case zanFood    = 4
    case zan6Notice = 5
    case zan6Guide  = 6
    case zanNotice  = 11
    case zanPerception = 12
    case zanMamaTopic = 13
    case zanTodayNotice = 14
    case zanMama = 15
    case zanMileStone = 19
}

class CiZanViewModel: NSObject {
    
    var zanModel: CiZanModel = CiZanModel()

    var zanTipString: String?
    
    var zanTipStringArray: [String] = ["zan_tip_string_1",
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
    
    func like(likeType: CiZanType , likeId: String , success: @escaping CompleteBlockWithoutReturnWithoutParameter, failed: @escaping CompleteBlockWithoutReturnWithoutParameter ){

//        CiMoyaRequest.rx_postRequest(target: .postLike(likeType.rawValue, likeId), completion: { (data) in
//            let json = data as! JSON
//            let diamondNumber = json["diamond"].intValue
//            self.zanTipString = LANG(key:(self.zanTipStringArray[(self.zanIndex)]))
//            if diamondNumber != 0 {
//                self.zanTipString = self.zanTipString?.appending("\n\(LANG(key: "mine_diamond_label_text"))+\(diamondNumber.description)")
//            }
//            success()
//        }) { () -> (Void) in
//            failed()
//        }
    }
    
}
