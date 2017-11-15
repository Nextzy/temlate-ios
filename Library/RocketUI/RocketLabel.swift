//
//  BaseLabel.swift
//  Template
//
//  Created by Thongpak on 7/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class RocketLabel: UILabel {
    
    @IBInspectable var labelStyle: String?
    @IBInspectable var fontSize: String?
    
    @IBInspectable var key: String?
    @IBInspectable var isUnderLine: Bool = false
    public var _labelStyle: MyAISLabelStyle {
        if let labelStyle = self.labelStyle {
            if labelStyle.lowercased().contains("topic") {
                return .Topic
            }
            if (labelStyle.lowercased().contains("detail")) {
                return .Detail
            }
        }
        return .None
    }
    
    public var _fontSize: RocketFontSize {
        if let fontStyle = self.fontSize {
            if fontStyle.lowercased().contains("extrasmall") {
                return .ExtraSmall
            }
            if fontStyle.lowercased().contains("small") {
                return .Small
            }
            if fontStyle.lowercased().contains("medium") {
                return .Medium
            }
            if fontStyle.lowercased().contains("extralarge") {
                return .ExtraLarge
            }
            if fontStyle.lowercased().contains("large") {
                return .Large
            }
        }
        return .Small
    }
    
    deinit {
        self.removeObserver()
    }
    
    override public func awakeFromNib() {
        self.localizeLabel()
        self.addObserver()
        self.setInterface()
    }
    
    public func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(RocketLabel.localizeLabel), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    public func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc public func localizeLabel() {
        
        if let key = self.key {
            self.text = key.localized()
            if self.isUnderLine {
                self.underLine()
            }
            self.fadeAnimation()
        }
    }
    
    // MARK: - Interface
    
    public func setInterface() {
        self.setLabelStyle()
        self.setFontSize()
    }
    
    public func setLabelStyle() {
        switch _labelStyle {
        case .Topic:
            self.setTopicLabel()
            break
        case .Detail:
            self.setDetaiLLabel()
            break
        case .None:
            break
        }
    }
    
    public func setFontSize() {
        switch _fontSize {
        case .ExtraSmall:
            self.font = RocketFontSize.ExtraSmall.getFont()
            break
        case .Small:
            self.font = RocketFontSize.Small.getFont()
            break
        case .Medium:
            self.font = RocketFontSize.Medium.getFont()
            break
        case .Large:
            self.font = RocketFontSize.Large.getFont()
            break
        case .ExtraLarge:
            self.font = RocketFontSize.ExtraLarge.getFont()
            break
        }
    }
    
    public func setTopicLabel() {
        self.text = self.text?.uppercased()
    }
    
    public func setDetaiLLabel() {
    }
    
    public enum MyAISLabelStyle {
        case Topic
        case Detail
        case None
    }
}
