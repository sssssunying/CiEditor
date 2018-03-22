//
//  SBaseViewController.swift
//  PregNotice
//
//  Created by 大大大大_荧🐾 on 2017/11/29.
//  Copyright © 2017年 孙荧. All rights reserved.
//

import UIKit
import SVProgressHUD
import StatefulViewController

class SBaseViewController: UIViewController, StatefulViewController {
    
    var isMock = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:BLACKLIGHTCOLOR]
        setupInitialViewState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.shadowImage   = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        // Setup placeholder views
//        loadingView = LoadingView(frame: view.frame)
//        emptyView = EmptyView(frame: view.frame)
//        let failureView = ErrorView(frame: view.frame)
//        failureView.tapGestureRecognizer.addTarget(self, action: #selector(reload))
//        errorView = failureView
    }
    
//    /// 错误视图重新加载调用
//    func reload() {
//
//    }
//
//    func checkNetwork() -> Bool {
//        if !Util.connectedToNetwork() {
//            errorOfNetwork()
//            return false
//        }
//        return true
//    }
//
//    func errorOfServer() {
//        (errorView as! ErrorView).switchErrorType(isNetwork: false)
//        self.endLoading(error: NSError(domain: "server error", code: -2, userInfo: nil))
//    }
//
//    func errorOfNetwork() {
//        (errorView as! ErrorView).switchErrorType(isNetwork: true)
//        self.endLoading(error: NSError(domain: "no net", code: -1, userInfo: nil))
//    }
//
//    /// 是否有内容
//    ///
//    /// - Returns: 默认返回无内容
//    func hasContent() -> Bool {
//        return false
//    }
//
//    func showLogin() {
//        showViewController(urlScheme: "\(SCHEME_URL_BASE)login?from=webview")
//    }
//
//    func back() {
//        SVProgressHUD.dismiss()
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func showViewController(urlScheme: String){
//        guard urlScheme.isEmpty == false else {
//            return
//        }
//        if urlScheme.contains(SCHEME_URL_BASE) {
//            SYUrlSchemeParse.deal(withSchemeUrl: urlScheme, withNavigation: self.navigationController , isPresent: false)
//        } else {
//            let tmpUrl = "\(SCHEME_URL_BASE)openweb?url=".appending(urlScheme)
//            SYUrlSchemeParse.deal(withSchemeUrl: tmpUrl, withNavigation: self.navigationController , isPresent: false)
//        }
//    }
//
//    func heightRatio() -> CGFloat {
//
//        return SCREENHEIGHT / 667
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
