//
//  BaseViewController.swift
//  Template
//
//  Created by Thongpak on 9/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit
import SVProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveLocalizable), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func didReceiveLocalizable() {
        
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
