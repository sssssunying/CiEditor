//
//  ViewController.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var replyView: CiEditorReplyView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(type: .custom)
        button.backgroundColor = .green
        button.setTitle("失败", for: .normal)
        button.setTitle("成功", for: .selected)
        button.frame = CGRect.init(x: 100, y: 100, width: 50, height: 50)
        button.ciAction(at: .touchUpInside) { (sender) in
            sender.isSelected = !sender.isSelected
        }
        view.addSubview(button)
        
       replyView = CiEditorReplyView.init(frame: CGRect(x: 0, y: SCREENHEIGHT - toolBarHeight - 44, width: SCREENWIDTH, height: toolBarHeight + 44))
        view.addSubview(replyView!)
        replyView?.parentViewController = self
        
        replyView?.sendClosure = {
            self.replyView?.sendCurrentEditorContent(isSuccess: button.isSelected)
            print("\(self.replyView?.content)\(self.replyView?.selectedImageArray)")
            
        }
        
        let tap = UITapGestureRecognizer()
        tap.ciAction { (gesture) in
            self.replyView?.textView.resignFirstResponder()
        }
        view.addGestureRecognizer(tap)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}



