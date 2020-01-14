//
//  ViewController.swift
//  WRSwiftKit
//
//  Created by Godfighter on 01/13/2020.
//  Copyright (c) 2020 Godfighter. All rights reserved.
//

import UIKit
import WRSwiftKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(WRDevice.isIpad) \n \(WRDevice.safeAreaInset) \n \(WRDevice.Info.appName)")
        
        print("\(WRDevice.Space.free.gbString)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

