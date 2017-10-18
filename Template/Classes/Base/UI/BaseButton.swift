
//
//  BaseButton.swift
//  Template
//
//  Created by Thongpak on 15/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    @IBInspectable var key: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        localizeButton()
        addObserver()
    }
    deinit {
        removeObserver()
    }
    
    @objc func localizeButton() {
        if let key = self.key {
            self.alpha = 0
            self.titleLabel?.text = key.localized()
            self.fadeIn()
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseButton.localizeButton), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
