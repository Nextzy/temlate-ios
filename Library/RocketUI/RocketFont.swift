//
//  RocketFont.swift
//  Rocket
//
//  Created by Thongpak on 6/11/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

public enum RocketFontSize {
    case ExtraSmall
    case Small
    case Medium
    case Large
    case ExtraLarge
    
    public func getFont() -> UIFont {
        switch self {
        case .ExtraSmall:
            return RocketFont.HelvethaicaAIS.ExtraSmall()
        case .Small:
            return RocketFont.HelvethaicaAIS.Small()
        case .Medium:
            return RocketFont.HelvethaicaAIS.Medium()
        case .Large:
            return RocketFont.HelvethaicaAIS.Large()
        case .ExtraLarge:
            return RocketFont.HelvethaicaAIS.ExtraLarge()
        }
    }
}

public enum RocketFont {
    case Tahoma
    case HelvethaicaAIS
    
    static let TahomaXSmall:  CGFloat = 10
    static let TahomaSmall:   CGFloat = 12
    static let TahomaMedium:  CGFloat = 15
    static let TahomaLarge:   CGFloat = 17
    static let TahomaXLarge:  CGFloat = 24
    
    static let AISXSmall:     CGFloat = 17
    static let AISSmall:      CGFloat = 20
    static let AISMedium:     CGFloat = 22
    static let AISLarge:      CGFloat = 25
    static let AISXLarge:     CGFloat = 32
    
    // Extra Small size
    
    public func ExtraSmall() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaXSmall : RocketFont.AISXSmall
        let type = self == .Tahoma ? FontType.Regular : FontType.AISRegular
        return withSize(size: size, type: type)
    }
    
    public func ExtraSmallBold() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaXSmall : RocketFont.AISXSmall
        let type = self == .Tahoma ? FontType.Bold : FontType.AISBold
        return withSize(size: size, type: type)
    }
    
    // Small size
    
    public func Small() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaSmall : RocketFont.AISSmall
        let type = self == .Tahoma ? FontType.Regular : FontType.AISRegular
        return withSize(size: size, type: type)
    }
    
    public func SmallBold() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaSmall : RocketFont.AISSmall
        let type = self == .Tahoma ? FontType.Bold : FontType.AISBold
        return withSize(size: size, type: type)
    }
    
    // Medium size
    
    public func Medium() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaMedium : RocketFont.AISMedium
        let type = self == .Tahoma ? FontType.Regular : FontType.AISRegular
        return withSize(size: size, type: type)
    }
    
    public func MediumBold() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaMedium : RocketFont.AISMedium
        let type = self == .Tahoma ? FontType.Bold : FontType.AISBold
        return withSize(size: size, type: type)
    }
    
    // Large size
    
    public func Large() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaLarge : RocketFont.AISLarge
        let type = self == .Tahoma ? FontType.Regular : FontType.AISRegular
        return withSize(size: size, type: type)
    }
    
    public func LargeBold() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaLarge : RocketFont.AISLarge
        let type = self == .Tahoma ? FontType.Bold : FontType.AISBold
        return withSize(size: size, type: type)
    }
    
    // Extra large
    
    public func ExtraLarge() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaXLarge : RocketFont.AISXLarge
        let type = self == .Tahoma ? FontType.Regular : FontType.AISRegular
        return withSize(size: size, type: type)
    }
    
    public func ExtraLargeBold() -> UIFont {
        let size = self == .Tahoma ? RocketFont.TahomaXLarge : RocketFont.AISXLarge
        let type = self == .Tahoma ? FontType.Bold : FontType.AISBold
        return withSize(size: size, type: type)
    }
    
    // Customize
    
    public func withSize(size: CGFloat, type: FontType) -> UIFont {
        switch self {
        case .Tahoma:
            return UIFont.Font(FontName.Tahoma, type: type, size: size)
        case .HelvethaicaAIS:
            return UIFont.Font(FontName.HelvethaicaAIS,type: type, size: size)
        }
    }
    
}

