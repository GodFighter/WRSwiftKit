//
//  ViewController.swift
//  WRSwiftKit
//
//  Created by Godfighter on 01/14/2020.
//  Copyright (c) 2020 Godfighter. All rights reserved.
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

        /*
        let image = UIImage.size(CGSize(width: 50, height: 50), image: UIImage(named: "wuren")!)
        let imageview = UIImageView(image: image)
        imageview.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        self.view.addSubview(imageview)
        */
        
        /*
        let view = UIView()
        view.backgroundColor = .blue
        view.frame = CGRect(x: 100, y: 100, width: 300, height: 200)
        self.view.addSubview(view);
        view.wr.clipCorner([.bottomLeft, .bottomRight], cornerRadius: CGSize(width: 20, height: 20))
        */
        /*
        let button = UIButton.init(type: .system)
        self.view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.backgroundColor = .blue
        button.setTitle("button", for: .normal)
        button.event(.touchDown) { (sender, event) in
            print("touchDown")
            }?.event(.touchUpInside, handler: { (sender, event) in
                print("touchUpInside")
            })
        */
        
        self.view.indicator.startAnimating(.audioEqualizer, size: CGSize(width: 40, height: 40), padding: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

