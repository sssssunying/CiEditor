
//
//  Config.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import Foundation
import UIKit
import Then
import SVProgressHUD

let SCHEME_URL_BASE = "ci123apps://www.ci123.com/pregnancy/"

typealias CompleteBlockWithoutReturnWithoutParameter = (() -> (Void))
typealias CompleteBlockWithoutReturnWithAnyParameter = ((Any) -> Void)

let success: ((String) -> Void) = { (text) in
    SVProgressHUD.showSuccess(withStatus: text.appending(LANG(key: "success")))
}

let failure: ((String) -> Void) = { (text) in
    SVProgressHUD.showError(withStatus: text.appending(LANG(key: "failed")))
}

let FONT30 = UIFont.systemFont(ofSize: 30.0 * VIEWUISCALE)
let FONT18 = UIFont.systemFont(ofSize: 18.0 * VIEWUISCALE)
let FONT16 = UIFont.systemFont(ofSize: 16.0 * VIEWUISCALE)
let FONT15 = UIFont.systemFont(ofSize: 15.0 * VIEWUISCALE)
let FONT14 = UIFont.systemFont(ofSize: 14.0 * VIEWUISCALE)
let FONT12 = UIFont.systemFont(ofSize: 12.0 * VIEWUISCALE)
let FONT10 = UIFont.systemFont(ofSize: 10.0 * VIEWUISCALE)
let FONT9 = UIFont.systemFont(ofSize: 9.0 * VIEWUISCALE)

let MEDIUMFONT30 = UIFont.init(name: "PingFangSC-Medium", size: 30.0 * VIEWUISCALE)
let MEDIUMFONT24 = UIFont.init(name: "PingFangSC-Medium", size: 24.0 * VIEWUISCALE)
let MEDIUMFONT20 = UIFont.init(name: "PingFangSC-Medium", size: 20.0 * VIEWUISCALE)
let MEDIUMFONT18 = UIFont.init(name: "PingFangSC-Medium", size: 18.0 * VIEWUISCALE)
let MEDIUMFONT17 = UIFont.init(name: "PingFangSC-Medium", size: 17.0 * VIEWUISCALE)
let MEDIUMFONT16 = UIFont.init(name: "PingFangSC-Medium", size: 16.0 * VIEWUISCALE)
let MEDIUMFONT15 = UIFont.init(name: "PingFangSC-Medium", size: 15.0 * VIEWUISCALE)
let MEDIUMFONT14 = UIFont.init(name: "PingFangSC-Medium", size: 14.0 * VIEWUISCALE)
let MEDIUMFONT12 = UIFont.init(name: "PingFangSC-Medium", size: 12.0 * VIEWUISCALE)

let GREYLIGHTCOLOR  = UIColor.colorWithHexString(hex: "#999999")
let BLACKLIGHTCOLOR = UIColor.colorWithHexString(hex: "#333333")
let LINECOLOR       = UIColor.colorWithHexString(hex: "#ececec")
let GREENMAINCOLOR  = UIColor.colorWithHexString(hex: "#65c4aa")
let BGCOLOR         = UIColor.colorWithHexString(hex: "#f3f3f3")
let GREYBGCOLOR     = UIColor.colorWithHexString(hex: "#cccccc")

let PLACEHOLDER       = UIImage.init(named: "netplaceholder")
let AVATARPLACEHOLDER = UIImage.init(named: "avatar_placeholder_green")

let SCREENWIDTH : CGFloat  = UIScreen.main.bounds.size.width
let SCREENHEIGHT : CGFloat = UIScreen.main.bounds.size.height
let VERSION : String       = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let iPhoneX : Bool         = __CGSizeEqualToSize(CGSize.init(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!)

let VIEWUISCALE: CGFloat = (SCREENWIDTH / 375.0)

var naviHeight: CGFloat {
    if #available(iOS 11.0, *) {
        if iPhoneX {
            return 120
        }
    }
    return 88.0
}

var toolBarHeight: CGFloat {
    if iPhoneX {
        return 83.0
    }
    return 49.0
}


func LANG(key : String) -> String {
    return key
}

extension UIControl {
    
    typealias controlActionClosure = ((UIControl)->Void)
    
    static let controlHandleValue = UnsafeRawPointer(bitPattern: "controlHandleValue".hashValue)
    
    func ciAction(at state:UIControlEvents,handle: controlActionClosure? ) {
        guard let actionHandle = handle else { return }
        objc_setAssociatedObject(self, UIControl.controlHandleValue!, actionHandle, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(UIControl.ciActionHandle), for: state)
    }
    
    @objc fileprivate func ciActionHandle() {
        guard let actionHandle = objc_getAssociatedObject(self, UIControl.controlHandleValue!) else { return }
        (actionHandle as! controlActionClosure)(self)
    }
    
}

extension UIGestureRecognizer {
    
    typealias gestureActionClosure = ((UIGestureRecognizer)->Void)
    
    static let gestureHandleValue = UnsafeRawPointer(bitPattern: "gestureHandleValue".hashValue)
    
    func ciAction(_ handle: gestureActionClosure? ) {
        guard let actionHandle = handle else { return }
        objc_setAssociatedObject(self, UIGestureRecognizer.gestureHandleValue!, actionHandle, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(UIGestureRecognizer.ciActionHandle))
    }
    
    @objc fileprivate func ciActionHandle() {
        guard let actionHandle = objc_getAssociatedObject(self, UIGestureRecognizer.gestureHandleValue!) else { return }
        (actionHandle as! gestureActionClosure)(self)
    }
    
}

extension UIColor {
    
    /// 颜色数值转换
    /// - Parameter hex: "#dddddd"
    /// - Returns: UIColor
    class func colorWithHexString(hex:String) ->UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
}


