//
//  ViewController.swift
//  WRSwiftKit
//
//  Created by Godfighter on 01/14/2020.
//  Copyright (c) 2020 Godfighter. All rights reserved.
//

import UIKit
import WRSwiftKit
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(WRDevice.Storage.total.description)
        print(123)
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
        
        /*
        let view = UIView.init(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        self.view.addSubview(view)
        
        view.indicator.startAnimating()
        */
//        self.initColor()
//        self.initString()
//        self.initImage()
        /*
        initCollection()
        */
        
//        initString()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initColor() {
        let color = UIColor.WR.Color(darkColor: .black, lightColor: .white);
        self.view.backgroundColor = color
        
        let color2 = UIColor(hexString: "DDF")
        view.backgroundColor = color2
        
        let randomColor = UIColor.WR.RandomColor
        view.backgroundColor = randomColor
    }
    
    func initString() {
        let ip: String = "192.1368.2.2"
        print(ip.wr.isIP)
        
        let http = "https%3A%2F%2Fwww.baidu.com"
        print(http.wr.urlDecoded)
                
        print("hello word".wr.words)
              
        let value = "1"
        print(value.wr.toBool)

        let float: CGFloat = 3.24
        print("\(float.wr.string(5))")
        
        let chinese = "高"
        print(chinese.wr.spellStripDiacritics)
        
    }
    
    func initImage() {
        var image = UIImage(named: "wuren")
        image = UIImage.WR.Cutting(image!, CGRect(x: 100, y: 100, width: 200, height: 200))

        
        //        image.Si
//        image?.wr.s
    }
    
    func initCollection() {
//        var dictionary: Dictionary<String, String> = ["123":"456"]
////        dictionary.wr_exchange(fromKey: "123", toKey: "789")
//
//        dictionary = dictionary.wr.exchange(fromKey: "123", toKey: "789")
//
//        print(dictionary)
        
//        let dict = [1 : "a", 2 : "b", 3 : "c", 4 : "d", 5 : "e"]
        let dict = ["1" : "a", "2" : "b", "3" : "c", "4" : "d", "5" : "e"]
        let newDict = dict.wr.jsonStirng
        print(newDict as Any)
        

    }
    

}

