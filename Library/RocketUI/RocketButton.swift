
//
//  BaseButton.swift
//  Template
//
//  Created by Thongpak on 15/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class RocketButton: UIButton {
    @IBInspectable var buttonStyle: String?
    @IBInspectable var fontSize: String?

    @IBInspectable var key: String?
    @IBInspectable var height: String?
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var cornerRadius: String?
    
    public var isTextButton: Bool {
        guard let titleLabel = self.titleLabel else { return false }
        return titleLabel.text != nil
    }
    
    var isImageButton: Bool {
        guard let imageView = self.imageView else { return false }
        return imageView.image != nil
    }
    
    public var disabled: Bool = false {
        didSet {
            self.setInterface()
        }
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
    
    var style: RocketButtonStyle {
        guard let btnStyle = self.buttonStyle else { return .None }
        if (btnStyle.lowercased().contains("gray")) {
            return .Gray
        } else if (btnStyle.lowercased().contains("green")) {
            return .Green
        } else {
            return .None
        }
    }
    
    deinit {
        self.removeObserver()
    }
    
    override public func awakeFromNib() {
        self.localizeButton()
        self.setInterface()
        self.addObserver()
    }
    
    //    override public func intrinsicContentSize() -> CGSize {
    //        if let height = self.height {
    //            let heightButton = NSNumberFormatter().numberFromString(height)
    //            let f = CGFloat(heightButton!)
    //            return CGSize(width: super.intrinsicContentSize().width, height: f)
    //        } else {
    //            return CGSize(width: super.intrinsicContentSize().width, height: 40)
    //        }
    //
    //    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(RocketButton.localizeButton), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func localizeButton() {
        if let key = self.key {
            if (isTextButton) {
                let title = key.localized()
                self.setTitle(title, for: .normal)
                self.fadeIn()
            }
            else if (isImageButton) {
                self.fadeIn(duration: 0.25, delay: 0.0, completion: { (_) in
                    let imageName = key.localized()
                    let image = UIImage(named: imageName)
                    self.setImage(image, for: .normal)
                })
            }
        }
    }
    
    // MARK: - Interface
    
    func setInterface() {
        if (!isTextButton) {
            return
        }
        
        if (disabled) {
            self.setButtonDisabled()
        } else {
            self.setButtonStyle()
            self.setButtonEnabled()
        }
        
        self.setButtonBorder()
        self.setFontSize()
    }
    
    public func setButtonStyle() {
        switch style {
        case .Gray:
            setGreyButton()
            break
        case .Green:
            setGreenButton()
            break
        case .None:
            break
        }
    }
    
    public func setButtonDisabled() {
        self.setTitleColor(RocketColor.White.color(), for: .normal)
        self.backgroundColor = RocketColor.MediumGray.color()
        self.setBackgroundColor(color: RocketColor.MediumGray.color(), forState: .normal)
        self.isUserInteractionEnabled = false
    }
    
    public func setButtonEnabled() {
        self.isUserInteractionEnabled = true
    }
    
    public func setFontSize() {
        switch _fontSize {
        case .ExtraSmall:
            self.titleLabel?.font = RocketFontSize.ExtraSmall.getFont()
            break
        case .Small:
            self.titleLabel?.font = RocketFontSize.Small.getFont()
            break
        case .Medium:
            self.titleLabel?.font = RocketFontSize.Medium.getFont()
            break
        case .Large:
            self.titleLabel?.font = RocketFontSize.Large.getFont()
            break
        case .ExtraLarge:
            self.titleLabel!.font = RocketFontSize.ExtraLarge.getFont()
            break
        }
    }
    
    func setButtonBorder() {
        if let radius = NumberFormatter().number(from: cornerRadius ?? "") {
            self.layer.cornerRadius = CGFloat(truncating: radius)
        } else {
            self.layer.cornerRadius = 3
        }
        self.layer.borderWidth = 1
        if let borderColor = self.borderColor {
            let color = borderColor
            self.layer.borderColor = color.cgColor
        } else {
            self.layer.borderColor  = RocketColor.White.color().cgColor
        }
        self.clipsToBounds = true
    }
    
    public func setGreenButton() {
        self.setTitleColor(RocketColor.DarkGreen.color(), for: .normal)
        self.setTitleColor(RocketColor.White.color(), for: .highlighted)
        self.setBackgroundColor(color: RocketColor.YellowGreen.color(), forState: .normal)
        self.setBackgroundColor(color: RocketColor.DimYellowGreen.color(), forState: .highlighted)
    }
    
    public func setGreyButton() {
        self.setTitleColor(RocketColor.MediumGray.color(), for: .normal)
        self.setTitleColor(RocketColor.White.color(), for: .highlighted)
        self.setBackgroundColor(color: RocketColor.LightGray.color(), forState: .normal)
        self.setBackgroundColor(color: RocketColor.DimLightGray.color(), forState: .highlighted)
    }
    
    enum RocketButtonStyle {
        case Green
        case Gray
        case None
    }
}
