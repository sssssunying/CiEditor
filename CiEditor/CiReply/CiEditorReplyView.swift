//
//  CiEditorReplyView.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit
import Stevia

class CiEditorReplyView: UIView {
    
    // MARK: 获取的内容
    var selectedImageArray: [UIImage] = []
    var content: String = ""
    
    // MARK: 初始化时设置的内容
    var parentViewController: UIViewController? {
        willSet{
            guard newValue != nil else {
                return
            }
            newValue?.view.addSubview(emojiView)
            pictureView.parentViewController = newValue
        }
    }

    /// 自定义键盘弹出时。。。
    var showKeyBoard: CompleteBlockWithoutReturnWithoutParameter?
    /// 自定义键盘隐藏时。。。
    var hideKeyBoard: CompleteBlockWithoutReturnWithoutParameter?
    var sendClosure : CompleteBlockWithoutReturnWithoutParameter?
    
    // MARK: 私有属性
    private var isKeyBoardShow  = false
    private var ciEmojiButton: CiEditorReplyViewToolButton?
    private var ciPicButton: CiEditorReplyViewToolButton?
    private var ciCamButton: CiEditorReplyViewToolButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow

        addSubview(textView)
        addSubview(sendButton)
        addSubview(toolView)
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyBoard(notifictaion:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyBoard(notifictaion:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didKeyBoardChangeFrame(notifictaion:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        sv(sendButton)

        sendButton.width(57).height(23).right(0)
        alignHorizontally(sendButton, with: textView)
        
        ciEmojiButton = CiEditorReplyViewToolButton(frame: CGRect.init(x: 52 * 0, y: 0, width: 52, height: 44))
        ciEmojiButton?.generateButton(imageName: "cireply_emjo")
        ciEmojiButton?.addTarget(self, action: #selector(emoji(sender:)), for: .touchUpInside)
        ciPicButton = CiEditorReplyViewToolButton(frame: CGRect.init(x: 52 * 1, y: 0, width: 52, height: 44))
        ciPicButton?.generateButton(imageName: "cireply_picture")
        ciPicButton?.addTarget(self, action: #selector(picture(sender:)), for: .touchUpInside)
        ciCamButton = CiEditorReplyViewToolButton(frame: CGRect.init(x: 52 * 2, y: 0, width: 52, height: 44))
        ciCamButton?.generateButton(imageName: "cireply_camare")
        ciCamButton?.addTarget(self, action: #selector(takePhoto(sender:)), for: .touchUpInside)
        
        toolView.addSubview(ciEmojiButton!)
        toolView.addSubview(ciPicButton!)
        toolView.addSubview(ciCamButton!)
        
        emojiView.clickOneClosure = { [weak self] (image) in
            self?.selectedImageArray = [image as! UIImage]
            guard self?.sendClosure != nil else {
                return
            }
            self?.sendClosure!()
        }
    }
    
    fileprivate lazy var pictureView: CiEditorReplyPictureView = {
        let view = CiEditorReplyPictureView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 258))
        view.isHidden = true
        return view
    }()
    
    fileprivate lazy var emojiView: CiEditorReplyEmojiView = {
        let view = CiEditorReplyEmojiView.init(frame: CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 180))
        view.isHidden = true
        return view
    }()
    
    fileprivate lazy var toolView: UIView = UIView().then {
        $0.frame = CGRect(x: 0, y: 50, width: SCREENWIDTH, height: 44)
    }
    
    fileprivate lazy var sendButton: UIButton = UIButton().then {
        $0.frame                      = CGRect.init(x: SCREENWIDTH - 57, y: 0, width: 57, height: 23)
        $0.showsTouchWhenHighlighted  = true
        $0.isEnabled                  = false
        $0.setTitle(LANG(key: "send"), for: .disabled)
        $0.setTitle(LANG(key: "send"), for: .normal)
        $0.setTitleColor(GREENMAINCOLOR, for: .normal)
        $0.setTitleColor(GREENMAINCOLOR.withAlphaComponent(0.5), for: .disabled)
        $0.ciAction(at: .touchUpInside, handle: {[weak self] (sender) in
            guard self?.sendClosure != nil else {
                return
            }
            self?.sendClosure!()
        })
    }
    
    lazy var textView: HPGrowingTextView = {
        let textView                           = HPGrowingTextView.init(frame: CGRect.init(x: 15, y: 7.5, width: SCREENWIDTH - 70 , height: 34))
        textView.isScrollable                  = true
        textView.contentInset                  = UIEdgeInsetsMake(0, 5, 0, 5)
        textView.backgroundColor               = UIColor.colorWithHexString(hex: "#f3f3f3")
        textView.minNumberOfLines              = 1
        textView.maxNumberOfLines              = 4
        textView.returnKeyType                 = UIReturnKeyType.send
        textView.enablesReturnKeyAutomatically = true
        textView.font                          = FONT14
        textView.textColor                     = BLACKLIGHTCOLOR
        textView.layer.cornerRadius            = 3.0
        textView.clipsToBounds                 = true
        textView.placeholder                   = LANG(key: "todaytipdetailreplyview_textview_placeholder")
        textView.delegate                      = self
        return textView
    }()
    
    fileprivate lazy var imagePicker: SYImagePicker = {
        let imagePicker = SYImagePicker.init()
        imagePicker.showViewController = self.parentViewController
        imagePicker.finishPickImage = { [weak self] image in
            
//                success(LANG(key: LANG(key: "milestone_uploading")))
//            }, failed: { () -> (Void) in
//                failure(LANG(key: LANG(key: "milestone_uploading")))
//            })
        
        }
        return imagePicker
    }()
    
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

extension CiEditorReplyView {
    
    func sendCurrentEditorContent( isSuccess: Bool) {
        content = textView.text
        
        if pictureView.isHidden == false {
            selectedImageArray = pictureView.selectedImageArray
        }
        if isSuccess == true {
            textView.text = ""
        }
        ciEmojiButton?.isSelected = false
        ciCamButton?.isSelected = false
        ciPicButton?.isSelected = false
        emojiView.isHidden = true
        pictureView.isHidden = true
        textView.resignFirstResponder()
        frame = CGRect(x: 0, y: SCREENHEIGHT - self.frame.height, width: SCREENWIDTH, height: self.frame.height)
    }
    
    @objc func emoji( sender: UIButton ) {
        emojiView.frame = CGRect(x: 0, y: SCREENHEIGHT - 180 - ((iPhoneX) ? 34 : 0), width: SCREENWIDTH, height: 180 + ((iPhoneX) ? 34 : 0))
        emojiView.isHidden = false
        var tmpFrame = self.frame
        tmpFrame.origin.y = SCREENHEIGHT - tmpFrame.size.height - (180 + ((iPhoneX) ? 34 : 0))
        self.frame = tmpFrame
        sender.isSelected = true
        pictureView.isHidden = true
        ciPicButton?.isSelected = false
        ciCamButton?.isSelected = false
        textView.resignFirstResponder()
    }
    
    @objc func picture( sender: UIButton ) {
        pictureView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - (258 + ((iPhoneX) ? 34 : 0)), width: SCREENWIDTH, height: 258 + ((iPhoneX) ? 34 : 0))
        pictureView.isHidden = false
        var tmpFrame = self.frame
        tmpFrame.origin.y = SCREENHEIGHT - tmpFrame.size.height - (258 + ((iPhoneX) ? 34 : 0))
        self.frame = tmpFrame
        sender.isSelected = true
        ciEmojiButton?.isSelected = false
        ciCamButton?.isSelected = false
        emojiView.isHidden = true
        textView.resignFirstResponder()
    }
    
    @objc func takePhoto( sender: UIButton ) {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == false else {
            imagePicker.imagePicker.sourceType = .camera
            parentViewController?.present(imagePicker.imagePicker, animated: true, completion: nil)
            return
        }
        failure(LANG(key: "dontOpenCamera"))
    }
    
    @objc func willHideKeyBoard (notifictaion: NSNotification) {
        guard isKeyBoardShow == true else {
            return
        }
        isKeyBoardShow             = false
        if (hideKeyBoard != nil) {
            hideKeyBoard!()
        }
        var frameOfView            = frame
        frameOfView.size.height    = frame.height
        frameOfView.origin.y       = SCREENHEIGHT - frameOfView.size.height
        let duration: TimeInterval = notifictaion.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let options: Int           = notifictaion.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UInt(options)), animations: {
            if self.emojiView.isHidden == false {
                self.frame = CGRect(x: 0, y: SCREENHEIGHT - self.frame.height - (180 + ((iPhoneX) ? 34 : 0)), width: SCREENWIDTH, height: self.frame.height)
            } else if self.pictureView.isHidden == false {
                self.frame = CGRect(x: 0, y: SCREENHEIGHT - self.frame.height - (258 + ((iPhoneX) ? 34 : 0)), width: SCREENWIDTH, height: self.frame.height)
            } else {
                self.frame = frameOfView
            }
            self.textView.frame.size.width = SCREENWIDTH -  70
            guard self.textView.text.isEmpty == true else {
                return
            }
        }) { (isFinish) in
        }
        
    }
    
    @objc func willShowKeyBoard (notifictaion: NSNotification) {
        guard isKeyBoardShow == false else {
            return
        }
        isKeyBoardShow                     = true
        if (showKeyBoard != nil) {
            showKeyBoard!()
        }
        emojiView.isHidden = true
        pictureView.isHidden = true
        let framOfKeyboard: CGRect = notifictaion.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        var frameOfView                    = frame
        frameOfView.size.height            = frame.height
        frameOfView.origin.y               = SCREENHEIGHT - frameOfView.size.height - framOfKeyboard.size.height
        let duration: TimeInterval         = notifictaion.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let options: Int = notifictaion.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UInt(options)), animations: {
            self.frame                     = frameOfView
            self.textView.frame.size.width = SCREENWIDTH - 15 - 57
        }) { (isFinish) in
        }
    }
    
    @objc func didKeyBoardChangeFrame(notifictaion: NSNotification) {
        guard isKeyBoardShow == true else {
            return
        }
        let framOfKeyboard: CGRect = notifictaion.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        var frameOfView                    = frame
        frameOfView.origin.y               = SCREENHEIGHT - frameOfView.size.height - framOfKeyboard.size.height
        let duration: TimeInterval         = notifictaion.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let options: Int = notifictaion.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UInt(options)), animations: {
            self.frame                     = frameOfView
            self.textView.frame.size.width = SCREENWIDTH - 15 - 57
        }) { (isFinish) in
        }
    }
    
}

extension CiEditorReplyView: HPGrowingTextViewDelegate {

    func growingTextViewDidChange(_ growingTextView: HPGrowingTextView!) {
        if growingTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 1 {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    
    func growingTextViewShouldReturn(_ growingTextView: HPGrowingTextView!) -> Bool {
        sendButton.isEnabled = false
        sendClosure!()
        return true
    }
    
    func growingTextView(_ growingTextView: HPGrowingTextView!, willChangeHeight height: Float) {

        let changeHeight = growingTextView.frame.size.height - CGFloat(height)
        var tmpRect = frame
        tmpRect.size.height -= changeHeight
        tmpRect.origin.y += changeHeight
        frame = tmpRect
        toolView.frame = CGRect(x: 0, y: tmpRect.size.height - 44 - ((iPhoneX) ? 34 : 0) , width: SCREENWIDTH, height: 44)
        
    }
    
}
