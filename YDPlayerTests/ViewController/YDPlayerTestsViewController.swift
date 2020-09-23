//
//  YDPlayerTestsViewController.swift
//  YDPlayerTests
//
//  Created by Douglas Hennrich on 29/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit
import YDPlayer

class YDPlayerTestsViewController: UIViewController {
    
    var config: YDPlayerConfiguration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        YDPlayerView(with: config, parent: view)
    }

}
