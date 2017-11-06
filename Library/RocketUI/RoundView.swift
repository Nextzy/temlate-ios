//
//  RoundView.swift
//  Template
//
//  Created by Thongpak on 16/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class RoundView: UIView {
    @IBInspectable var _borderColor: UIColor?
    override func awakeFromNib() {
        super.awakeFromNib()
        setRoundConer()
    }
    
    func setRoundConer() {
        if let color = _borderColor {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 1
        }
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
