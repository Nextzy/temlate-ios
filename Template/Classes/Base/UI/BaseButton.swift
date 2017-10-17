
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
        localizeLabel()
        addObserver()
    }
    deinit {
        removeObserver()
    }
    
    @objc func localizeLabel() {
        if let key = self.key {
            self.fadeIn(duration: 2, completion: { (finish) in
                self.titleLabel?.text = key.localized()
            })
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseLabel.localizeLabel), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
