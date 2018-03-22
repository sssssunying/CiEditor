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
            self.goViewController(type: ciEditorReplyViewTypeAll)
        }
        view.addSubview(tmpp)
        
        
    }
    
    func goViewController(type: CiEditorType) {
        let vc = CiEditorFactory.createEditor(editorType: type)
        navigationController?.pushViewController(vc, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}



