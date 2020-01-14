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

        /*
        WRFolder.cacheUrl = Bundle.main.bundleURL
        print("\(WRFolder.folderSize(WRFolder.cacheUrl!))")
         */
        
        /*
        let email = "100000000000@qq.com"
        print("\(email.wr.isEmail)")
         */
        
        /*
        let image = UIImage.Rotate.horizontal(UIImage(named: "wuren")!);
        let imageview = UIImageView(image: image)
        imageview.frame = CGRect(x: 0, y: 100, width: 102.4, height: 136.5)
        self.view.addSubview(imageview)
         */
        
        let image = UIImage.size(UIImage(named: "wuren")!, size: CGSize(width: 50, height: 50))
        let imageview = UIImageView(image: image)
        imageview.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        self.view.addSubview(imageview)


//        print("\(UIImage.WR)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

