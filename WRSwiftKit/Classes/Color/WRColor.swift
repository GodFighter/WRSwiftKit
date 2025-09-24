//
//  WRColor.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

//MARK:-  Initializers
@objc public extension UIColor {
    
    /// 整型初始化
    ///
    /// 0 ～ 255的整形值
    ///
    /// - parameter red: 红
    /// - parameter green: 绿
    /// - parameter blue: 蓝
    /// - parameter blue: 蓝
    /// - parameter wr_alpha: 透明度
    ///
    convenience init(red: Int, green: Int, blue: Int, _ wr_alpha: CGFloat = 1) {
        let safeRed = max(min(255, red), 0)
        let safeGreen = max(min(255, green), 0)
        let safeBlue = max(min(255, blue), 0)
        let safeAlpha = max(min(1.0, wr_alpha), 0.0)

        self.init(red: CGFloat(safeRed) / 255.0, green: CGFloat(safeGreen) / 255.0, blue: CGFloat(safeBlue) / 255.0, alpha: safeAlpha)
    }

    /// 16进制数初始化
    ///
    /// - parameter hex: 16进制数
    /// - parameter wr_alpha: 透明度
    convenience init(hex:Int, alpha: CGFloat = 1) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, alpha)
    }

    /// 16进制字符串初始化
    /// - Parameters:
    ///   - hexString: 16进制字符串
    ///   - wr_alpha: 透明度
    convenience init?(hexString: String, alpha: CGFloat = 1) {
        var string = ""
        
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        guard let hexValue = Int(string, radix: 16) else { return nil }
        self.init(hex: hexValue, alpha: alpha)
    }
    
    static func Hex(_ hex: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor.init(hex: hex, alpha: alpha)
    }
    
    static func HexString(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        return UIColor.init(hexString: hex, alpha: alpha) ?? .white
    }

}

//MARK:-
@objc public protocol UIColorProtocol{
}

@objc extension UIColor : UIColorProtocol {
    public override var wr: UIColorExtension {
        return UIColorExtension(self)
    }
    public static var WR: UIColorExtension.Type {
        return UIColorExtension.self
    }
}

//MARK:-  Static
fileprivate typealias UIColorExtension_Static = UIColorExtension
public extension UIColorExtension_Static {
    /**随机颜色*/
    @objc static var RandomColor : UIColor {
        return UIColor(red: Int.random(in: 0...255), green: Int.random(in: 0...255), blue: Int.random(in: 0...255))
    }
    
    /**暗黑模式颜色*/
    /**
    iOS13.0以下的，显示light颜色
    */
    
    @objc static func Color(darkColor dark: UIColor, lightColor light: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                return trainCollection.userInterfaceStyle == .light ? light : dark
            }
        }
        return light
    }
    
    /// 颜色初始化
    ///
    /// 暗黑颜色非必需
    /// - parameter light: 正常模式颜色
    /// - parameter dark: 暗黑模式颜色
    /// - returns: 颜色

    @objc static func Color(color light: UIColor, dark: UIColor? = nil) -> UIColor {
        return Color(darkColor: dark == nil ? light : dark!, lightColor: light)
    }

}
//MARK:-  Property
fileprivate typealias UIColorExtension_Public = UIColorExtension
public extension UIColorExtension_Public {

    var floatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let red = _components[0]
        let green = _components[1]
        let blue = _components[2]
        return (red: red, green: green, blue: blue)
    }
    
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        return (red: Int(floatComponents.red * 255.0), green: Int(floatComponents.green * 255.0), blue: Int(floatComponents.blue * 255.0))
    }

    @objc var hex: UInt {
        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(_components[0] * 255.0) << 16
        colorAsUInt32 += UInt32(_components[1] * 255.0) << 8
        colorAsUInt32 += UInt32(_components[2] * 255.0)
        return UInt(colorAsUInt32)
    }

    @objc var hexString: String {
        let components: [Int] = _components.map { Int($0 * 255.0) }
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }

    @objc var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }

}

//MARK:-
@objc public class UIColorExtension : WRObjectExtension {
    init(_ value: UIColor){
        super.init(value)
        self.value = value
    }
    
    fileprivate var _color: UIColor {
        guard let color = self.value as? UIColor else {
            return .clear
        }
        return color
    }
        
    fileprivate var _components: [CGFloat] {
        let comps = _color.cgColor.components!
        if comps.count == 4 { return comps }
        return [comps[0], comps[0], comps[0], comps[1]]
    }
}

