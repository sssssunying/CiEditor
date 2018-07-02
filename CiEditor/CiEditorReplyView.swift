//
//  CiEditorReplyView.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit
import Stevia
import Photos

class CiEditorReplyView: UIView {
    
    var viewModel: CiEditorViewModel = CiEditorViewModel()
    
    var parentViewController: UIViewController? {
        willSet{
            guard newValue != nil else {
                return
            }
            newValue?.view.addSubview(emojiView)
            pictureView.parentViewController = newValue
        }
    }
    
    var pictureMaxCount: Int = 1
    var showKeyBoard: CompleteBlockWithoutReturnWithoutParameter?
    var hideKeyBoard: CompleteBlockWithoutReturnWithoutParameter?
    var sendClosure : CompleteBlockWithoutReturnWithoutParameter?
    
    
    private var isKeyBoardShow = false
    private var ciEmojiButton: CiBaseButton?
    private var ciPicButton: CiBaseButton?
    private var ciCamButton: CiBaseButton?
    private var ciShaBuuton: CiBaseButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        addSubview(textView)
        addSubview(sendButton)
        addSubview(toolView)
        
        initNotification()
        
        sv(sendButton, textView,toolView)
        layout(
            7.5,
            |-15-textView-57-|,
            7.5,
            |toolView| ~ 44,
            (iPhoneX ? 34 : 0)
        )
        sendButton.width(57).height(23).right(0)
        alignHorizontally(sendButton, with: textView)
    }
    
    fileprivate lazy var imageCountTipLabel: UILabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = FONT10
        $0.frame = CGRect.init(x: 0, y: 0, width: 12, height: 12)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6.0
        $0.backgroundColor = UIColor.colorWithHexString(hex: "#FFB800")
        $0.isHidden = true
    }
    
    fileprivate lazy var pictureView: CiEditorReplyPictureView = {
        let view = CiEditorReplyPictureView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 258), maxCount: pictureMaxCount)
        view.didSelectedOneCallBack = { [weak self](selectedCount) in
            let tmp: Int = selectedCount as! Int
            if tmp > 0 {
                self?.imageCountTipLabel.isHidden = false
                self?.imageCountTipLabel.text = tmp.description
            } else {
                self?.imageCountTipLabel.isHidden = true
            }
        }
        view.isHidden = true
        return view
    }()
    
    fileprivate lazy var emojiView: CiEditorReplyEmojiView = {
        let view = CiEditorReplyEmojiView.init(frame: CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 180))
        view.isHidden = true
        view.clickOneClosure = { selectedEmoji in
            
        }
        return view
    }()
    
    fileprivate lazy var toolView: UIView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 44)
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
    
    lazy var zanButton: ZanButton = ZanButton().then {
        $0.frame = CGRect.init(x: 0 , y: 0, width: 40, height: 49)
        $0.setButtonStyle(style: "topLeft")
        $0.viewModel =  ZanViewModel.init(zan: CiZan.init(zanType: CiZanType.zanMamaTopic, zanId: "1", zanNum: 11, isZan: false))
    }
    
    fileprivate lazy var shareBottom: NewShareControlView = {
        let share                      = NewShareControlView()
        share.shareControlViewDelegate = self
        return share
    }()
    
    fileprivate lazy var imagePicker: SYImagePicker = {
        let imagePicker = SYImagePicker.init()
        imagePicker.showViewController = self.parentViewController
        imagePicker.finishPickImage = { [weak self] image in
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: { (writeSuccess, error) in
                if writeSuccess == true {
                    DispatchQueue.main.async {
                        self?.picture(sender: (self?.ciPicButton!)!)
                    }
                }
            })
        }
        return imagePicker
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deInitNotification()
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
    
    func refreshUI(replyType: CiEditorType) {
        let tmp = generateToolViewButton(replyType: replyType)
        for one in tmp {
            toolView.addSubview(one)
        }
    }
    
    fileprivate func generateToolViewButton(replyType: CiEditorType) -> [UIButton] {
        
        switch replyType {
        case ciEditorReplyViewTypeAll:
            ciEmojiButton = CiBaseButton(frame: CGRect.init(x: 52 * 0, y: 0, width: 52, height: 44))
            ciEmojiButton?.generateButton(imageName: "cireply_emjo")
            ciEmojiButton?.addTarget(self, action: #selector(emoji(sender:)), for: .touchUpInside)
            ciPicButton = CiBaseButton(frame: CGRect.init(x: 52 * 1, y: 0, width: 52, height: 44))
            ciPicButton?.generateButton(imageName: "cireply_picture")
            imageCountTipLabel.frame = CGRect.init(x: 52 - 12 - 6, y: 6, width: 12, height: 12)
            ciPicButton?.addSubview(imageCountTipLabel)
            ciPicButton?.addTarget(self, action: #selector(picture(sender:)), for: .touchUpInside)
            ciCamButton = CiBaseButton(frame: CGRect.init(x: 52 * 2, y: 0, width: 52, height: 44))
            ciCamButton?.generateButton(imageName: "cireply_camare")
            ciCamButton?.addTarget(self, action: #selector(takePhoto(sender:)), for: .touchUpInside)
            return [ciEmojiButton!, ciPicButton!, ciCamButton!]
        case ciEditorReplyViewTypeMamaTopic:
            ciPicButton = CiBaseButton(frame: CGRect.init(x: 52 * 0, y: 0, width: 52, height: 44))
            ciPicButton?.generateButton(imageName: "cireply_picture")
            imageCountTipLabel.frame = CGRect.init(x: 52 - 12 - 6, y: 6, width: 12, height: 12)
            ciPicButton?.addSubview(imageCountTipLabel)
            ciPicButton?.addTarget(self, action: #selector(picture(sender:)), for: .touchUpInside)
            ciCamButton = CiBaseButton(frame: CGRect.init(x: 52 * 1, y: 0, width: 52, height: 44))
            ciCamButton?.generateButton(imageName: "cireply_camare")
            ciCamButton?.addTarget(self, action: #selector(takePhoto(sender:)), for: .touchUpInside)
            ciShaBuuton = CiBaseButton(frame: CGRect.init(x: 52 * 2, y: 0, width: 52, height: 44))
            ciShaBuuton?.setImage(UIImage(named:"todaytipdetailheaderbottomview_share"), for: .normal)
            return [ciPicButton!, ciCamButton!, ciShaBuuton!]
        default:
            ciPicButton = CiBaseButton(frame: CGRect.init(x: 52 * 0, y: 0, width: 52, height: 44))
            ciPicButton?.generateButton(imageName: "cireply_picture")
            imageCountTipLabel.frame = CGRect.init(x: 52 - 12 - 6, y: 6, width: 12, height: 12)
            ciPicButton?.addSubview(imageCountTipLabel)
            ciPicButton?.addTarget(self, action: #selector(picture(sender:)), for: .touchUpInside)
            ciCamButton = CiBaseButton(frame: CGRect.init(x: 52 * 1, y: 0, width: 52, height: 44))
            ciCamButton?.generateButton(imageName: "cireply_camare")
            ciCamButton?.addTarget(self, action: #selector(takePhoto(sender:)), for: .touchUpInside)
            ciShaBuuton = CiBaseButton(frame: CGRect.init(x: 52 * 2, y: 0, width: 44, height: 44))
            ciShaBuuton?.setImage(UIImage(named:"todaytipdetailheaderbottomview_share"), for: .normal)
            ciShaBuuton?.addTarget(self, action: #selector(share(sender:)), for: .touchUpInside)
            zanButton.frame = CGRect.init(x: 52 * 3 , y: 0, width: 44, height: 44)
            return [ciPicButton!, ciCamButton!, ciShaBuuton!, zanButton]
        }
    }
    
    @objc func share( sender: UIButton) {
        textView.resignFirstResponder()
        shareBottom.postShareSuccessToSever = {
            
        }
        shareBottom.title     = "todaytip_share_icon"
        shareBottom.content   = "todaytip_share_icon"
        shareBottom.url       = "todaytip_share_icon"
        shareBottom.image     = UIImage.init(named: "todaytip_share_icon")
        shareBottom.show(in: self.parentViewController)
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
        pictureView.reObtainLocalData()
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
        guard pictureView.vc.selectedSource.count < pictureMaxCount else {
            failure("Max Selected")
            return
        }
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == false else {
            imagePicker.imagePicker.sourceType = .camera
            parentViewController?.present(imagePicker.imagePicker, animated: true, completion: nil)
            return
        }
        failure(LANG(key: "dontOpenCamera"))
    }
    
    fileprivate func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyBoard(notifictaion:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyBoard(notifictaion:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didKeyBoardChangeFrame(notifictaion:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    fileprivate func deInitNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
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
        viewModel.postModel.contentString = growingTextView.text
        sendButton.isEnabled = viewModel.checkSendCondition()
    }
    
    func growingTextViewShouldReturn(_ growingTextView: HPGrowingTextView!) -> Bool {
        sendButton.isEnabled = false
        sendClosure!()
        return true
    }
    
    func growingTextView(_ growingTextView: HPGrowingTextView!, willChangeHeight height: Float) {
        let changeHeight = growingTextView.frame.size.height - CGFloat(height)
        var tmpRect      = frame
        tmpRect.size.height -= changeHeight
        tmpRect.origin.y += changeHeight
        frame = tmpRect
        
    }
    
}

extension CiEditorReplyView: ShareControlViewDelegate {
    
    
    
}
