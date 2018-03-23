//
//  CiEditorViewController.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/23.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit
import Photos

class CiEditorViewController: SBaseViewController {
    
    var viewModel: CiEditorViewModel = CiEditorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 37))
        backButton.setImage(UIImage(named: "return"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        let tmp = UIBarButtonItem.init(customView: backButton)
        navigationItem.leftBarButtonItems = [tmp]
    }
    
    private var ciPicButton: CiBaseButton?
    private var ciCamButton: CiBaseButton?
    private var pictureMaxCount: Int = 1
    private let pictrueViewHeight: CGFloat = 258 + ((iPhoneX) ? 34 : 0)
    
    fileprivate lazy var toolView: UIView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 44)
        $0.backgroundColor = .white
    }
    
    fileprivate lazy var imagePicker: SYImagePicker = {
        let imagePicker = SYImagePicker.init()
        imagePicker.showViewController = self
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
        view.parentViewController = self
        return view
    }()
    
    fileprivate lazy var contentTextView: UITextView = UITextView().then {
        $0.font = FONT14
        $0.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        $0.backgroundColor = BGCOLOR
        $0.delegate = self
        $0.text = LANG(key: "BBSViewC_tipToSendTopicButton_title")
        $0.textColor = BLACKLIGHTCOLOR
    }
    
    fileprivate lazy var titleTextField: UITextField = UITextField().then {
        $0.returnKeyType = .send
        $0.delegate = self
        $0.placeholder = "\(LANG(key: "enter"))\(LANG(key: "title"))"
        $0.font = FONT15
        $0.backgroundColor = .white
        let tmpLeftView = UIView.init(frame: CGRect.init(x: 00, y: 0, width: 13, height: 30))
        $0.leftView = tmpLeftView
        $0.leftViewMode = .always
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CiEditorViewController {
// MARK: 公用
    /// 生成界面
    func generateView() {
        title = viewModel.editorType
        ciPicButton = CiBaseButton(frame: CGRect.init(x: 52 * 0, y: 0, width: 52, height: 44))
        ciPicButton?.generateButton(imageName: "cireply_picture")
        imageCountTipLabel.frame = CGRect.init(x: 52 - 12 - 6, y: 6, width: 12, height: 12)
        ciPicButton?.addSubview(imageCountTipLabel)
        ciPicButton?.addTarget(self, action: #selector(picture(sender:)), for: .touchUpInside)
        ciCamButton = CiBaseButton(frame: CGRect.init(x: 52 * 1, y: 0, width: 52, height: 44))
        ciCamButton?.generateButton(imageName: "cireply_camare")
        ciCamButton?.addTarget(self, action: #selector(takePhoto(sender:)), for: .touchUpInside)
    
        toolView.addSubview(ciCamButton!)
        toolView.addSubview(ciPicButton!)
        
        switch viewModel.editorType {
        case ciEditorTypeWriteDiary:
            contentTextView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 190)
            view.addSubview(contentTextView)
            toolView.frame = CGRect.init(x: 0, y: 190, width: SCREENWIDTH, height: 44)
            break
        default:
            pictureMaxCount = 9
            titleTextField.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 51)
            view.addSubview(titleTextField)
            contentTextView.frame = CGRect.init(x: 0, y: 51, width: SCREENWIDTH, height: 190)
            view.addSubview(contentTextView)
            toolView.frame = CGRect.init(x: 0, y: 241, width: SCREENWIDTH, height: 44)
            break
        }
        view.addSubview(toolView)
    }
    
    @objc func picture( sender: UIButton ) {
        pictureView.reObtainLocalData()
        pictureView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - (iPhoneX ? 88 : 64) - pictrueViewHeight, width: SCREENWIDTH, height: pictrueViewHeight)
        pictureView.isHidden = false
        sender.isSelected = true
        ciCamButton?.isSelected = false
        hideKeyBroad()
    }
    
    @objc func takePhoto( sender: UIButton ) {
        guard pictureView.vc.selectedSource.count < pictureMaxCount else {
            failure("Max Selected")
            return
        }
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == false else {
            imagePicker.imagePicker.sourceType = .camera
            present(imagePicker.imagePicker, animated: true, completion: nil)
            return
        }
        failure(LANG(key: "dontOpenCamera"))
    }
    
    fileprivate func hideKeyBroad() {
        contentTextView.resignFirstResponder()
        if viewModel.editorType == ciEditorTypePostTopic {
            titleTextField.resignFirstResponder()
        }
    }
    
// MARK: 发帖界面专用
    
    
    
   
// MARK: 写日记专用
    
    
    
}

extension CiEditorViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == LANG(key: "BBSViewC_tipToSendTopicButton_title") {
            textView.text = ""
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.postModel.contentString = textView.text
        
        
    }
    
    
}

extension CiEditorViewController: UITextFieldDelegate {
    
}

