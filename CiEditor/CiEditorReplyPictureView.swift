//
//  CiEditorReplyPictureView.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/6.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorReplyPictureView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parentViewController: UIViewController? {
        willSet{
            guard newValue != nil else {
                return
            }
            newValue?.view.addSubview(self)
        }
    }
    
    var selectedImageArray: [UIImage] = []
    fileprivate var maxNumber: Int?
    fileprivate var currentCount: Int = 0
    
    fileprivate let vc = MTImagePickerController.instance
    
    var groupModel:MTImagePickerAlbumModel!
    
    private var dataSource = [MTImagePickerModel]()
    
    init(frame: CGRect, maxCount: Int) {
        super.init(frame: frame)
        self.maxNumber = maxCount
        
        backgroundColor = .white
        bottomView.addSubview(libraryButton)
        bottomView.addSubview(countLabel)
        addSubview(bottomView)
        addSubview(collectionView)
        
        sv(bottomView.sv(libraryButton,countLabel))
        
        let bottomBlank: CGFloat = ((iPhoneX) ? 34 : 0)
        
        libraryButton.top(0).left(0).bottom(0).width(72)
        countLabel.top(0).right(20).bottom(0).width(100)
        
        bottomView.left(0).right(0).bottom(bottomBlank).height(44)
        
        refreshCountLabel()
        
        MTImagePickerDataSource.fetchDefault(type: .Photos, mediaTypes: [MTImagePickerMediaType.Photo]) {
            $0.getMTImagePickerModelsListAsync { (models) in
                self.dataSource = models
                self.collectionView.reloadData()
            }
        }
        
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        let view = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 214), collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(CiEditorReplyPictrueCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CiEditorReplyPictrueCollectionViewCell.self))
        return view
    }()
    
    fileprivate lazy var bottomView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    fileprivate lazy var countLabel: UILabel = UILabel().then {
        $0.textColor = BLACKLIGHTCOLOR
        $0.font = FONT12
        $0.textAlignment = .right
    }
    
    fileprivate lazy var libraryButton = UIButton().then{
        $0.setTitle(LANG(key: "album"), for: .normal)
        $0.setTitleColor(BLACKLIGHTCOLOR, for: .normal)
        $0.titleLabel?.font = FONT16
        $0.ciAction(at: .touchUpInside) { [weak self] (sender) in
            self?.showMTImagePicker()
        }
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

extension CiEditorReplyPictureView {
    
    func showMTImagePicker() {
        vc.mediaTypes = [MTImagePickerMediaType.Photo]
        vc.source = MTImagePickerSource.Photos
        vc.imagePickerDelegate = self
        vc.maxCount = maxNumber ?? 1
        vc.defaultShowCameraRoll = true
        parentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func refreshCurrentView() {
        refreshCountLabel()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func refreshCountLabel() {
        currentCount = vc.selectedSource.count
        let attribute = NSMutableAttributedString()
        attribute.append(NSAttributedString.init(attributedString: NSAttributedString.init(string: currentCount.description, attributes: [NSAttributedStringKey.font: MEDIUMFONT20 as Any,NSAttributedStringKey.foregroundColor:(BLACKLIGHTCOLOR)])))
        attribute.append(NSAttributedString.init(string: "/".appending((maxNumber?.description)!), attributes: [NSAttributedStringKey.font: FONT14 as Any,NSAttributedStringKey.foregroundColor:(BLACKLIGHTCOLOR)]))
        countLabel.attributedText = attribute
    }
    
}

extension CiEditorReplyPictureView: MTImagePickerControllerDelegate {
    
    func imagePickerController(picker: MTImagePickerController, didFinishPickingWithPhotosModels models: [MTImagePickerPhotosModel]) {
        vc.selectedSource = models
        refreshCurrentView()
    }
    
    func imagePickerController(picker: MTImagePickerController, didFinishPickingWithAssetsModels models: [MTImagePickerAssetsModel]) {
        vc.selectedSource = models
        refreshCurrentView()
    }
    
    func imagePickerControllerDidCancel(picker: MTImagePickerController) {
        print("cancel")
    }
    
}

extension CiEditorReplyPictureView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CiEditorReplyPictrueCollectionViewCell.self), for: indexPath) as! CiEditorReplyPictrueCollectionViewCell
        let model = dataSource[indexPath.row]
        cell.imageView.image = model.getPreviewImage()
        cell.btnCheck.isSelected = vc.selectedSource.contains(model)
        cell.btnCheck.addTarget(self, action: #selector(btnCheckClick(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnCheckClick(sender: UIButton) {
        if vc.selectedSource.count < maxNumber! || sender.isSelected == true {
            sender.isSelected = !sender.isSelected
            let cell = sender.superview?.superview as! CiEditorReplyPictrueCollectionViewCell
            let index = collectionView.indexPath(for: cell)?.row
            if sender.isSelected {
                vc.selectedSource.append(dataSource[index!])
                sender.heartbeatsAnimation(duration: 0.15)
            }else {
                if let removeIndex = vc.selectedSource.index(of: dataSource[index!]) {
                    vc.selectedSource.remove(at: removeIndex)
                }
            }
            refreshCurrentView()
        } else {
            let alertView = FlashAlertView(message: "Maxium selected".localized, delegate: nil)
            alertView.show()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.dataSource[indexPath.row]
        let tmpSize = model.getPreviewImage()?.size
        return CGSize.init(width: (tmpSize?.width)! / (tmpSize?.height)! * 214.0, height: 214.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
}

