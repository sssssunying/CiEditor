//
//  CiEditorReplyEmojiView.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorReplyEmojiView: UIView {
    
    var clickOneClosure: CompleteBlockWithoutReturnWithAnyParameter?
    fileprivate let titleArray = [LANG(key: "move"), LANG(key: "angry"), LANG(key: "cry"), LANG(key: "awkward"), LANG(key: "cool"), LANG(key: "like")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainCollectionView)
    }
    
    fileprivate lazy var mainCollectionView: UICollectionView = {
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize.init(width: SCREENWIDTH / 3, height: 90)
        layOut.minimumInteritemSpacing = 0.0
        layOut.minimumLineSpacing = 0.0
        let view = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 180), collectionViewLayout: layOut)
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.register(OneToolCell.self, forCellWithReuseIdentifier: NSStringFromClass(OneToolCell.self))
        return view
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

extension CiEditorReplyEmojiView: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(OneToolCell.self), for: indexPath) as! OneToolCell
        cell.showImageView.image = UIImage(named: "ciemoji_" + indexPath.row.description)
        cell.titleLabel.text = titleArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard clickOneClosure != nil else {
            return
        }
        clickOneClosure!(UIImage(named: "ciemoji_" + indexPath.row.description) as Any)
    }
    
    
}




