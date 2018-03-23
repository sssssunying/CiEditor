//
//  CiZanView.swift
//  PregNotice
//
//  Created by sy on 2017/10/10.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import Stevia
import SVProgressHUD


class CiZanButton: UIButton {
    
    var viewModel = CiZanViewModel()
 
    var postSuccess: CompleteBlockWithoutReturnWithAnyParameter?
    
    init(frame: CGRect , likeType: Int , likeId: String) {
        super.init(frame: frame)
        titleEdgeInsets            = UIEdgeInsetsMake(5, 10, 0, 0)
        titleLabel?.font           = FONT12
        titleLabel?.textColor      = BLACKLIGHTCOLOR
        showsTouchWhenHighlighted  = true
        isHidden                   = false
        setTitle(viewModel.zanModel.normalTitle, for: .normal)
        setTitleColor(BLACKLIGHTCOLOR, for: .normal)
        setTitleColor(GREENMAINCOLOR, for: .selected)
        setImage(viewModel.zanModel.normalImage, for: .normal)
        setImage(viewModel.zanModel.selectedImage, for: .selected)
        addOnlyButtonAction(likeType: CiZanType(rawValue: likeType)!, likeId: likeId,
                            successed: { [weak self] in
                                ZanButton.showZanTipView(tipString: (self?.viewModel.zanTipString!)!)
                                if self?.postSuccess != nil {
                                    self?.postSuccess!(self as Any)
                                }},
                            failed: {failure(LANG(key: "todaytipdetailheaderbottomview_zanbutton"))})
    }
    
    init(frame: CGRect , likeType: CiZanType , likeId: String ) {
        super.init(frame: frame)
        titleEdgeInsets            = UIEdgeInsetsMake(10, -2, 25, 0)
        titleLabel?.font           = .systemFont(ofSize: 10.0)
        titleLabel?.textColor      = BLACKLIGHTCOLOR
        showsTouchWhenHighlighted  = true
        isHidden                   = false
        setTitle(viewModel.zanModel.normalTitle, for: .normal)
        setTitleColor(BLACKLIGHTCOLOR, for: .normal)
        setTitleColor(GREENMAINCOLOR, for: .selected)
        setImage(viewModel.zanModel.normalImage, for: .normal)
        setImage(viewModel.zanModel.selectedImage, for: .selected)
        addOnlyButtonAction(likeType: likeType, likeId: likeId,
                            successed: { [weak self] in
                                ZanButton.showZanTipView(tipString: (self?.viewModel.zanTipString!)!)
                                if self?.postSuccess != nil {
                                    self?.postSuccess!(self as Any)
                                }},
                            failed: {failure(LANG(key: "todaytipdetailheaderbottomview_zanbutton"))})
    }
    
    init(frame: CGRect, hasBorder: Bool , likeType: CiZanType , likeId: String ) {
        super.init(frame: frame)
        buildCurrentView(hasBorder: hasBorder)
        addAction(likeType: likeType, likeId: likeId,
                  successed: { [weak self] in
                    ZanButton.showZanTipView(tipString: (self?.viewModel.zanTipString!)!)
                    if self?.postSuccess != nil {
                        self?.postSuccess!(self as Any)
                    }},
                  failed: {failure(LANG(key: "todaytipdetailheaderbottomview_zanbutton"))})
    }
    
    func resetButton(zanModel: CiZanModel) {
        
    }
    
    func tmpSetTipLabelTitle(normalTitle: String) {
        
        viewModel.zanModel.normalTitle = normalTitle
        
    }
        
// MARK: 构建点赞事件
    private func addOnlyButtonAction(likeType: CiZanType , likeId: String , successed: @escaping CompleteBlockWithoutReturnWithoutParameter, failed: @escaping CompleteBlockWithoutReturnWithoutParameter) {
        ciAction(at: .touchUpInside) {[weak self] (sender) in
//            guard CiUser.sharedInstance().isLogin() == true else {
//                self?.showLogin()
//                return
//            }
//            sender.enlarge(to: 1.5, duration: 0.5)
            self?.isSelected = !sender.isSelected
            if sender.isSelected == false {
                self?.postZanToServer(likeType: likeType, likeId: likeId, success:successed, failed: failed)
                if self?.title(for: .selected) == "1" {
                    self?.setTitle(self?.viewModel.zanModel.normalTitle, for: .normal)
                } else {
                    let tmp = Int((self?.title(for: .selected)!)!)! - 1
                    self?.setTitle(tmp.description, for: .normal)
                }
            } else {
                self?.postZanToServer(likeType: likeType, likeId: likeId, success: successed, failed: failed)
                if self?.title(for: .normal) != self?.viewModel.zanModel.normalTitle {
                    let tmp = Int((self?.title(for: .normal)!)!)! + 1
                    self?.setTitle(tmp.description, for: .selected)
                } else {
                    self?.setTitle("1", for: .selected)
                }
            }
        }
    }
    
    private func addAction(likeType: CiZanType , likeId: String , successed: @escaping CompleteBlockWithoutReturnWithoutParameter, failed: @escaping CompleteBlockWithoutReturnWithoutParameter) {
        ciAction(at: .touchUpInside) {[weak self] (sender) in
            
//            guard CiUser.sharedInstance().isLogin() == true else {
//                self?.showLogin()
//                return
//            }
//
//            self?.tipImageView.enlarge(to: 1.2, duration: 0.25)
            self?.zanAnimation()
            if self?.tipLabel.textColor != self?.viewModel.zanModel.selectedColor { // 点赞
                self?.postZanToServer(likeType: likeType, likeId: likeId, success: successed, failed: failed)
                self?.tipImageView.image = self?.viewModel.zanModel.selectedImage
                self?.tipLabel.textColor = self?.viewModel.zanModel.selectedColor
                if (self?.tipLabel.text == self?.viewModel.zanModel.normalTitle) {
                    if self?.viewModel.zanModel.selectedTitle == "0" {
                        self?.tipLabel.text = "1"
                    } else {
                        let tmp = Int((self?.viewModel.zanModel.selectedTitle)!)! + 1
                        self?.tipLabel.text = tmp.description
                    }
                } else {
                    let tmp = Int((self?.tipLabel.text)!)! + 1
                    self?.tipLabel.text = tmp.description
                    
                }
                self?.layer.borderColor  = GREENMAINCOLOR.cgColor
                self?.isSelected = true
            } else {                                        // 取消
                self?.postZanToServer(likeType: likeType, likeId: likeId, success: successed, failed: failed)
                self?.tipImageView.image = UIImage.init(named: "todaytipdetailheaderbottomview_zan")
                self?.tipLabel.textColor = self?.viewModel.zanModel.normalColor
                if (self?.tipLabel.text == "1") {
                    self?.tipLabel.text = self?.viewModel.zanModel.normalTitle
                } else {
                    let tmp = Int((self?.tipLabel.text)!)! - 1
                    self?.tipLabel.text = tmp.description
                }
                self?.layer.borderColor  = BLACKLIGHTCOLOR.cgColor
                self?.isSelected = false
            }
        }
    }
    
// MARK: 构建点赞控件UI
    private func buildCurrentView( hasBorder: Bool ){
        
        addSubview(tipImageView)
        addSubview(tipLabel)
        sv(
            tipImageView,
            tipLabel
        )
        layout(
            "",
            |-30-tipImageView-8-tipLabel-20-|,
            ""
        )
        tipLabel.height(15)
        tipLabel.width(frame.size.width-56)
        tipImageView.height(24)
        tipImageView.width(18)
        alignHorizontally(tipImageView,tipLabel,self)
        
        if hasBorder == true {
            generateBorderButton()
        } else {
            generateNonBorderButton()
        }

    }

// MARK: 无边框单元格中按钮
    private func generateNonBorderButton(){
        tipLabel.text      = viewModel.zanModel.normalTitle
        tipLabel.font      = FONT12
        tipLabel.textAlignment = .left
    }
    
// MARK: 边框圆角按钮
    private func generateBorderButton(){
        let height         = frame.size.height
        clipsToBounds      = true
        layer.cornerRadius = height / 2
        layer.borderColor  = BLACKLIGHTCOLOR.cgColor
        layer.borderWidth  = 1.0
        tipLabel.text      = LANG(key: "todaytipdetailheaderbottomview_zanbutton")
        tipLabel.textAlignment = .center
    }
    
// MARK: 登陆页面
    private func showLogin() {
//        let tabbar: GTabBar = UIApplication.shared.keyWindow?.rootViewController as! GTabBar
//        let tmpViewController = tabbar.tabViewControllers[tabbar.currentSelectedIndex]
//        SYUrlSchemeParse.deal(withSchemeUrl: "\(SCHEME_URL_BASE)login?from=webview", withNavigation: tmpViewController as! UINavigationController , isPresent: false)
        
    }
    
// MARK: 小控件init
    lazy var tipImageView: UIImageView = {
        let imageView         = UIImageView()
        imageView.contentMode = .center
        imageView.image       = UIImage.init(named: "todaytipdetailheaderbottomview_zan")
        return imageView
    }()
    
    lazy var tipLabel: UILabel = {
        let label                      = UILabel()
        label.textColor                = BLACKLIGHTCOLOR
        label.font                     = FONT14
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CiZanButton {
    
    // MARK: 点赞交互服务端
    fileprivate func postZanToServer( likeType: CiZanType , likeId: String , success: @escaping CompleteBlockWithoutReturnWithoutParameter, failed: @escaping CompleteBlockWithoutReturnWithoutParameter ) {
        viewModel.like(likeType: likeType, likeId: likeId, success: success, failed: failed)
    }
    
    // MARK: 点赞手指动画
    fileprivate func zanAnimation() {
        
        let pathFrame = CGRect.init(x: -tipImageView.bounds.midX - 3 , y: -tipImageView.bounds.midY , width: 24, height: 24)
        let path = UIBezierPath.init(roundedRect: pathFrame, cornerRadius: 12.0)
        let shapePosition = tipImageView.convert(tipImageView.center, from: self)
        
        let circleShape = CAShapeLayer()
        circleShape.path = path.cgPath
        circleShape.position = shapePosition
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.opacity = 0
        circleShape.strokeColor = GREENMAINCOLOR.cgColor
        circleShape.lineWidth = 0.5
        tipImageView.layer.addSublayer(circleShape)
        
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
    
}
