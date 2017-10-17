//
//  BaseLabel.swift
//  Template
//
//  Created by Thongpak on 7/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
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
            self.fadeIn(duration: 3, completion: { (_) in
                self.text = key.localized()
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
