//
//  CiEditorReplyViewViewController.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/22.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorReplyViewViewController: SBaseViewController {
    
    fileprivate var replyView: CiEditorReplyView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CiEditorReplyViewViewController {
    
    /// 生成回复框
    func generateReplyView(replyType: CiEditorType) {
        replyView = CiEditorReplyView.init(frame: CGRect(x: 0, y: SCREENHEIGHT - toolBarHeight - 44, width: SCREENWIDTH, height: toolBarHeight + 44))
        view.addSubview(replyView!)
        replyView?.parentViewController = self
        
        replyView?.sendClosure = {}
        
        
        let tap = UITapGestureRecognizer()
        tap.ciAction {[weak self] (gesture) in
            self?.replyView?.textView.resignFirstResponder()
        }
        view.addGestureRecognizer(tap)
        replyView?.refreshUI(replyType: replyType)
    }
    
    
}
