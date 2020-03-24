//
//  WRColor.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

@objc public protocol UIColorProtocol{
    var wr: UIColorExtension { get }
    
    @objc static func color(fromHexString: String) -> UIColor
}

@objc extension UIColor : UIColorProtocol {
    public override var wr: UIColorExtension {
        return UIColorExtension(self)
    }
    /**根据16进制创建颜色*/
    /// - parameter fromHexString: 16进制字符串
    /// - returns: 颜色
    @objc public static func color(fromHexString: String) -> UIColor {
        var rgbValue : UInt64 = 0
        let hex = fromHexString.replacingOccurrences(of: "#", with: "")

        if Scanner(string:hex).scanHexInt64(&rgbValue) {
            let redValue = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let greenValue = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
            let blueValue = CGFloat(rgbValue & 0xFF) / 255.0
            
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        }
        
        return .clear
    }
    
    public static var WR: UIColorExtension.Type {
        get { return UIColorExtension.self }
        set {}
    }
}

@objc public class UIColorExtension : WRObjectExtension {
    init(_ value: UIColor){
        super.init(value)
        self.value = value
    }
    
    /**随机颜色*/
    @objc public var randomColor : UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
    
    @objc public static func Color(darkMode dark: UIColor, _ light: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                return trainCollection.userInterfaceStyle == .light ? light : dark
            }
        }
        return light
    }
}
