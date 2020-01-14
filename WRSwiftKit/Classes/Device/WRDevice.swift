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
                
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS max"
            case "iPhone11,8":                              return "iPhone XR"

            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"

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

    @objc public class Language : NSObject {

        /** 检查系统中文*/
        @objc public static func isChinese() -> Bool {
            return self.checkLanguage(["zh-Hans", "zh-Hant"])
        }

        @objc public static func checkLanguage(_ languages : [String]) -> Bool {
            
            let defaults = UserDefaults.standard
            if let allLanguages : [String] = defaults.object(forKey: "AppleLanguages") as? [String]{
                
                let preferLanguage = allLanguages[0]
                let range : Range<String.Index> = preferLanguage.startIndex ..< preferLanguage.endIndex
                
                for language in languages{
                    
                    if (preferLanguage.range(of: language, options: String.CompareOptions.caseInsensitive, range: range, locale: nil) != nil){
                        return true
                    }
                }
            }
            
            return false
        }

    }

    @objc public class  Sensor: NSObject {
                    
        //屏幕亮度
        @objc public static func setBrightness(_ brightnessValue : CGFloat){
            UIScreen.main.brightness = brightnessValue
        }
        
        //感应黑屏
        @objc public static func setProximityMonitoringEnabled(enabled : Bool){
            UIDevice.current.isProximityMonitoringEnabled = enabled
        }
    }

    @objc public enum Space : Int{
        
        case free
        
        case total
        
        //MARK: - Space
                
        public var value : Double{
            
            guard let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else{
                return 0
            }
            
            switch self{
            case .free: return Double((attributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.uint64Value ?? 0)
            case .total: return attributes[FileAttributeKey.systemSize] as? Double ?? 0
            }
        }
        
        public var gbString : String{
            
            switch self{
            case .free: return String(format: "%.2fGB", WRDevice.doubleGbSpace(space: self.value))
            case .total: return WRDevice.calculateDeviceSpace(spaceGb: self.value)
            }
        }
    }
    
    private static func doubleGbSpace(space: Double) -> Double {
        return space / 1024.0 / 1024.0 / 1024.0
    }
    
    private static func calculateDeviceSpace(spaceGb: Double) -> String {
        
        if spaceGb < 8 {
            return "8GB"
        }
        else if spaceGb > 8 && spaceGb < 16 {
            return "16GB"
        }
        else if spaceGb > 16 && spaceGb < 32 {
            return "32GB"
        }
        else if spaceGb > 32 && spaceGb < 64 {
            return "64GB"
        }
        else if spaceGb > 64 && spaceGb < 128 {
            return "128GB"
        }
        else if spaceGb > 128 && spaceGb < 256 {
            return "256GB"
        }
        else{
            return "512GB"
        }
    }
    
    @objc public static func spaceValue(_ space : Space) -> Double {
        guard let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else{
            return 0
        }

        switch space{
        case .free: return Double((attributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.uint64Value ?? 0)
        case .total: return attributes[FileAttributeKey.systemSize] as? Double ?? 0
        }
    }

    @objc public static func gbString(_ space : Space) -> String {
        switch space{
        case .free: return String(format: "%.2fGB", WRDevice.doubleGbSpace(space: space.value))
        case .total: return WRDevice.calculateDeviceSpace(spaceGb: space.value)
        }
    }

}


