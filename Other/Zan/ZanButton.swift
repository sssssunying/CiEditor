//
//  ZanButton.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2017/11/21.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import Stevia
import RxSwift
import RxCocoa
import SVProgressHUD
import SwiftyJSON

enum ZanType: Int {
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
}

class ZanButton: UIButton {

    var viewModel: ZanViewModel? {
        willSet{
            guard newValue != nil else {
                return
            }
        }
        didSet{
            iconImageView.image = (viewModel?.zanModel.isZan == true && ((viewModel?.zanModel.zanNum)! > 0)) ? viewModel?.zanModel.selectedImage : viewModel?.zanModel.normalImage
            numberLabel.textColor = (viewModel?.zanModel.isZan == true && ((viewModel?.zanModel.zanNum)! > 0)) ? viewModel?.zanModel.selectedColor : viewModel?.zanModel.normalColor
            numberLabel.text    = ((viewModel?.zanModel.zanNum)! > 0) ?  viewModel?.zanModel.zanNum.description : viewModel?.zanModel.normalTitle
        }
    }
    
    private let disposeBag = DisposeBag()
    fileprivate var isShowQ = true
    
    var clickClosure: CompleteBlockWithoutReturnWithAnyParameter?
    var loginClosure: CompleteBlockWithoutReturnWithoutParameter?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(numberLabel)
        bindViewModel()
        
    }
    
    func setButtonStyle(style: String) {
        switch style {
        case "align":
            layOutAlign()
            break
        case "topLeft":
            layOutTopLeft()
            break
        case "vertical":
            layOutVertical()
            break
        default:
            break
        }
    }
    
    
    func bindViewModel() {
        
        self.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            
//            guard CiUser.sharedInstance().isLogin() else {
//                guard self?.loginClosure != nil else {
//                    return
//                }
//                self?.loginClosure!()
//                return
//            }
            
            if self?.viewModel?.zanModel.isZan == true {
                self?.viewModel?.zanModel.zanNum -= 1
            } else {
                self?.viewModel?.zanModel.zanNum += 1
            }
            self?.viewModel?.zanModel.isZan = !(self?.viewModel?.zanModel.isZan)!
            if (self?.viewModel?.zanModel.isZan)! {
                self?.iconImageView.image = self?.viewModel?.zanModel.selectedImage
                self?.numberLabel.text = self?.viewModel?.zanModel.zanNum.description
                self?.numberLabel.textColor = self?.viewModel?.zanModel.selectedColor
                if (self?.isShowQ)! {
                    self?.zanAnimation()
                }
            } else {
                self?.iconImageView.image = self?.viewModel?.zanModel.normalImage
                self?.numberLabel.text = (self?.viewModel?.zanModel.zanNum == 0) ? self?.viewModel?.zanModel.normalTitle : self?.viewModel?.zanModel.zanNum.description
                self?.numberLabel.textColor = self?.viewModel?.zanModel.normalColor
            }
//
//        CiMoyaRequest.rx_postRequest(target: .postLike((self?.viewModel?.zanModel.zanType.rawValue)!, (self?.viewModel?.zanModel.zanId)!), completion: { (data) in
//                let json = data as! JSON
//                let diamondNumber = json["diamond"].intValue
//                var tmpTipString = self?.viewModel?.zanModel.zanTipString
//                if diamondNumber != 0 {
//                    tmpTipString = tmpTipString?.appending("\n\(LANG(key: "mine_diamond_label_text"))+\(diamondNumber.description)")
//                }
//                self?.viewModel?.zanModel.showTipString = tmpTipString!
//
//            if self?.viewModel?.zanModel.isZan == true {
////                ZanButton.showZanTipView(tipString: (self?.viewModel?.zanModel.showTipString)!)
//            }
//
//                self?.isSelected = (self?.viewModel?.zanModel.isZan)!
//                guard self?.clickClosure != nil else {
//                    return
//                }
//                self?.clickClosure!(self?.viewModel?.zanModel as Any)
//            }, failed: {
//            })
//            }, onError: { (error) in
        }, onCompleted: {
        }, onDisposed: {
        }).addDisposableTo(disposeBag)
        
    }
    
    lazy var iconImageView = UIImageView().then {
        $0.contentMode     = .center
    }
    
    lazy var numberLabel = UILabel().then {
        $0.textColor     = BLACKLIGHTCOLOR
        $0.font          = FONT14
        $0.adjustsFontSizeToFitWidth     = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: 点赞界面样式
extension ZanButton {
    
    fileprivate func layOutTopLeft() {
        let sHeight = self.frame.size.height
        numberLabel.font = FONT10
        sv(iconImageView, numberLabel)
        iconImageView.width(18).height(<=sHeight).left(0)
        numberLabel.height(<=sHeight).right(0).top(5).left(14)
        alignHorizontally(iconImageView,self)
    }
    
    fileprivate func layOutAlign() {
        let sHeight = self.frame.size.height
        sv(iconImageView, numberLabel)
        layout(
            "",
            |-iconImageView-numberLabel-| ~ 24,
            ""
        )
        iconImageView.width(18).height(<=sHeight)
        numberLabel.height(<=sHeight).right(0)
        alignHorizontally(iconImageView, numberLabel ,self)
    }
    
    fileprivate func layOutVertical() {
        isShowQ = false
        sv(iconImageView, numberLabel)
        layout(
            0,
            |iconImageView| ~ 82,
            4,
            |numberLabel| ~ 20,
            0
        )
        numberLabel.textAlignment = .center
        alignVertically(iconImageView, numberLabel ,self)
    }
    
    
}

// MARK: 点赞界面效果
extension ZanButton {
    //  点赞手指动画
    fileprivate func zanAnimation() {
        
        let pathFrame = CGRect.init(x: -iconImageView.bounds.midX - 3 , y: -iconImageView.bounds.midY , width: 24, height: 24)
        let path = UIBezierPath.init(roundedRect: pathFrame, cornerRadius: 12.0)
        let shapePosition = iconImageView.convert(iconImageView.center, from: self)
        
        let circleShape = CAShapeLayer()
        circleShape.path = path.cgPath
        circleShape.position = shapePosition
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.opacity = 0
        circleShape.strokeColor = GREENMAINCOLOR.cgColor
        circleShape.lineWidth = 0.5
        iconImageView.layer.addSublayer(circleShape)
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DIdentity)
        scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(2.0, 2.0, 1))
        
        let alphaAnimation = CABasicAnimation.init(keyPath: "opacity")
        alphaAnimation.fromValue = 1
        alphaAnimation.toValue = 0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation,alphaAnimation]
        groupAnimation.duration = 0.5
        groupAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        circleShape.add(groupAnimation, forKey: nil)
    }
    
    // 点赞tip弹框
    class func showZanTipView(tipString: String){
        let label                       = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 30))
        label.clipsToBounds             = true
        label.layer.cornerRadius        = 15.0
        label.backgroundColor           = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        label.font                      = FONT12
        label.textColor                 = .white
        label.numberOfLines             = 2
        label.isHidden                  = true
        label.adjustsFontSizeToFitWidth = true
        label.center = CGPoint.init(x: SCREENWIDTH / 2.0, y: SCREENHEIGHT / 2.0)
        UIApplication.shared.windows[0].addSubview(label)
        label.isHidden = false
        UIApplication.shared.windows[0].bringSubview(toFront: label)
        label.text = tipString
        label.sizeToFit()
        let tmpWidth = (label.frame.size.width) + 40
        label.frame = CGRect.init(x: SCREENWIDTH / 2 - tmpWidth / 2, y: SCREENHEIGHT / 2 - 64, width: tmpWidth, height: (label.frame.size.height) + 20)
        label.textAlignment = .center
//        label.zoomInView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            label.zoomOutView()
            label.removeFromSuperview()
        }
    }
}
