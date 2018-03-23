//
//  CiEditorReplyViewViewController.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/22.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class CiEditorReplyViewViewController: SBaseViewController {
    
    var viewModel: CiEditorViewModel = CiEditorViewModel()
    
    fileprivate var replyView: CiEditorReplyView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmpp = UIButton.init(frame: CGRect.init(x: 50, y: 150, width: 200, height: 30))
        tmpp.setTitle("戳我返回", for: .normal)
        tmpp.ciAction(at: .touchUpInside) { [weak self] (sender) in
            self?.dismiss(animated: true, completion: nil)
        }
        view.addSubview(tmpp)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CiEditorReplyViewViewController {
    
    /// 生成回复框
    func generateReplyView() {
        
        replyView = CiEditorReplyView.init(frame: CGRect(x: 0, y: SCREENHEIGHT - toolBarHeight - 44, width: SCREENWIDTH, height: toolBarHeight + 44))
        view.addSubview(replyView!)
        replyView?.viewModel = viewModel
        replyView?.parentViewController = self
        
        replyView?.sendClosure = {}
        
        
        let tap = UITapGestureRecognizer()
        tap.ciAction {[weak self] (gesture) in
            self?.replyView?.textView.resignFirstResponder()
        }
        view.addGestureRecognizer(tap)
        
        let long = UILongPressGestureRecognizer()
        long.ciAction {[weak self] (gesture) in
            self?.dismiss(animated: true, completion: nil)
        }
        view.addGestureRecognizer(long)
        
        replyView?.refreshUI(replyType: viewModel.editorType)
    }
    
    
}
