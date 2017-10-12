//
//  ViewController.swift
//  Template
//
//  Created by Thongpak on 6/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero
class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogo()
    }
    
    func setLogo() {
        let logo = #imageLiteral(resourceName: "nextzy_logo_black_logo_only")
        let imageView = UIImageView(image: logo)
        imageView.isHeroEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.heroID = "test"
        imageView.heroModifiers = [.arc]
        self.navigationItem.titleView = imageView

    }
}

