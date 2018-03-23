//
//  ViewController.swift
//  CiEditor
//
//  Created by 大大大大_荧🐾 on 2018/3/5.
//  Copyright © 2018年 大大大大_荧🐾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .black
        
        let tmp = UIButton.init(frame: CGRect.init(x: 10, y: 100, width: 200, height: 30))
        tmp.setTitle("帖子回复框", for: .normal)
        tmp.ciAction(at: .touchUpInside) { (sender) in
            self.goViewController(type: ciEditorReplyViewTypeAll)
        }
        view.addSubview(tmp)
        
        let tmpp = UIButton.init(frame: CGRect.init(x: 10, y: 150, width: 200, height: 30))
        tmpp.setTitle("妈妈说回复框", for: .normal)
        tmpp.ciAction(at: .touchUpInside) { (sender) in
            self.goViewController(type: ciEditorReplyViewTypeMamaTopic)
        }
        view.addSubview(tmpp)
        
        let tmppp = UIButton.init(frame: CGRect.init(x: 10, y: 200, width: 200, height: 30))
        tmppp.setTitle("今日提醒回复框", for: .normal)
        tmppp.ciAction(at: .touchUpInside) { (sender) in
            self.goViewController(type: ciEditorReplyViewTypeTodayNotice)
        }
        view.addSubview(tmppp)
        
        let tmqp = UIButton.init(frame: CGRect.init(x: 10, y: 250, width: 200, height: 30))
        tmqp.setTitle("发帖页面", for: .normal)
        tmqp.ciAction(at: .touchUpInside) { (sender) in
            self.goViewController(type: ciEditorTypePostTopic)
        }
        view.addSubview(tmqp)
        
        let tmpw = UIButton.init(frame: CGRect.init(x: 10, y: 300, width: 200, height: 30))
        tmpw.setTitle("写日记", for: .normal)
        tmpw.ciAction(at: .touchUpInside) { (sender) in
            self.goViewController(type: ciEditorTypeWriteDiary)
        }
        view.addSubview(tmpw)
        
    }
    
    func goViewController(type: CiEditorType) {
        let vc = CiEditorFactory.createEditor(editorType: type)
        present(vc, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}



