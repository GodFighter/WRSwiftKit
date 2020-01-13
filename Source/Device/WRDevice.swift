//
//  WRDevice.swift
//  Pods-WRKit_Example
//
//  Created by xianghui-iMac on 2020/1/13.
//

import UIKit

@objc public class WRDevice: NSObject {

    @objc public static var isIpad : Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    @objc public static var isIphone : Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    @objc public static var safeAreaInset : UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if (UIApplication.shared.keyWindow != nil) {
                return (UIApplication.shared.keyWindow?.safeAreaInsets)!;
            }
        }
        return UIEdgeInsets.zero
    }

    @objc public static var isAllScreen : Bool {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return self.safeAreaInset.left > 0.0
        } else {
            return self.safeAreaInset.top > 20.0
        }
    }
}

@objc public class Info : NSObject {
    /** 设备分辨率*/
    @objc public static var resolution : String { //设备分辨率
        
        let scale = UIScreen.main.scale
        let width = Int(UIScreen.main.bounds.width * scale)
        let height = Int(UIScreen.main.bounds.height * scale)
        
        return "\(width)x\(height)"
    }

    /** 设备类型*/
    @objc public static var model: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
            
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPhone10,1":                              return "iPhone 8"
        case "iPhone10,4":                              return "iPhone 8"
        case "iPhone10,2":                              return "iPhone 8 Plus"
        case "iPhone10,5":                              return "iPhone 8 Plus"
        case "iPhone10,3":                              return "iPhone X"
        case "iPhone10,6":                              return "iPhone X"
            
        default:                                        return identifier
        }
    }

    /** 设备UUID*/
    @objc public static var uuid : String {
        return UIDevice.current.identifierForVendor!.uuidString//UIDevice.current.uniqueDeviceIdentifier()
    }

    /** 设备名称*/
    @objc public static var name : String { return UIDevice.current.name }
    
    /** 应用名称*/
    @objc public static var appName : String { return Bundle.main.infoDictionary!["CFBundleName"] as! String }
    
    /** 系统版本号*/
    @objc public static var systemVersion : String { return UIDevice.current.systemVersion }
    
    /** 应用 build 版本号*/
    @objc public static var buildVersion : String { return Bundle.main.infoDictionary!["CFBundleVersion"] as! String }
    
    /** 应用版本号*/
    @objc public static var clientVersion : String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String }

}
