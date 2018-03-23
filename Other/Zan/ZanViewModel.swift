//
//  ZanViewModel.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2017/11/21.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
import Moya

class ZanViewModel: NSObject {
    
    
    var zanModel: CiZan
    
    init( zan: CiZan ) {
        zanModel   = zan
    }
    
//    func transform(input: Input) -> Output {
//
//        let tmpZanModel = Driver.of(zanModel)
//
//         let tmpOutput = input.clickTrigger
//            .withLatestFrom(tmpZanModel)
//            .flatMapLatest{ (zan) -> SharedSequence<DriverSharingStrategy, CiZan> in
//                return postProvider.rx.request(.postLike(zan.zanType.rawValue, zan.zanId))
//                           .filterSuccessfulStatusAndRedirectCodes()
//                           .mapJSON()
//                           .map { tmp in
//                                let json = JSON.init(tmp)
//                                if json["status"] == "success" {
//                                    let diamondNumber = json["data"]["diamond"].intValue
//                                    var tmpTipString = zan.zanTipString
//                                    if diamondNumber != 0 {
//                                        tmpTipString = tmpTipString.appending("\n\(LANG(key: "mine_diamond_label_text"))+\(diamondNumber.description)")
//                                    }
//                                    self.zanModel.showTipString = tmpTipString
//                                    if self.zanModel.isZan == true {
//                                        self.zanModel.zanNum -= 1
//                                    } else {
//                                        self.zanModel.zanNum += 1
//                                    }
//                                    self.zanModel.isZan = !self.zanModel.isZan
//                                }
//                            return self.zanModel
//                    }.asDriver(onErrorJustReturn: self.zanModel)
//            }.asDriver()
//
//        return Output.init(clickZan: tmpOutput)
//
//    }
    
}

extension ZanViewModel {
    
    struct Input {
        let clickTrigger: Driver<Void>
    }
    
    struct Output {
        let clickZan: Driver<CiZan>
    }
    
}
