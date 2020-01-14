//
//  ViewController.swift
//  WRSwiftKit
//
//  Created by GodFighter on 01/14/2020.
//  Copyright (c) 2020 GodFighter. All rights reserved.
//

import UIKit
import WRSwiftKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WRFolder.cacheUrl = Bundle.main.bundleURL
        print("\(WRFolder.folderSize(WRFolder.cacheUrl!))")

        let email = "100000000000@qq.com"
        
        print("\(email.wr.isEmail)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

