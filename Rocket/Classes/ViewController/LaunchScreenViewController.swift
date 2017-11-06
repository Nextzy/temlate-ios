//
//  LaunchScreenViewController.swift
//  Template
//
//  Created by Thongpak on 12/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit

class LaunchScreenViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }
}
