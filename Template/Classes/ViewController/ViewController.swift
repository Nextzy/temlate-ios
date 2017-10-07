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
import Localize_Swift
class ViewController: UIViewController {
    @IBOutlet weak var toggleButton: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleButton.rx.tap.asObservable().subscribe { (_) in
            if Localize.currentLanguage() == "en" {
                Localize.setCurrentLanguage("th")
            } else {
                Localize.setCurrentLanguage("en")
            }
            
        }.disposed(by: disposeBag)
    }
}

