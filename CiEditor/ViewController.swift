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
        // Do any additional setup after loading the view, typically from a nib.
        
        replyView = CiEditorReplyView.init(frame: CGRect(x: 0, y: SCREENHEIGHT - toolBarHeight - 44, width: SCREENWIDTH, height: toolBarHeight + 44))
        view.addSubview(replyView!)
        replyView?.parentViewController = self
        
        let tap = UITapGestureRecognizer()
        tap.ciAction {[weak self] (gesture) in
            self?.replyView?.textView.resignFirstResponder()
        }
        view.addGestureRecognizer(tap)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}



