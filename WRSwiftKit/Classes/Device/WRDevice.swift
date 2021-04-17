//
//  WRDevice.swift
//  Pods-WRKit_Example
//
//  Created by xianghui-iMac on 2020/1/13.
//

import UIKit


@objc public class WRDevice: NSObject {
    
    @objc static let Shared: WRDevice = {
        let shared = WRDevice()
        return shared
    }()
}

//MARK: -
fileprivate typealias Judge = WRDevice
public extension Judge {
    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var isAllScreen : Bool {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return safeAreaInset.left > 0.0
        } else {
            return safeAreaInset.bottom > 20.0
        }
    }

}

//MARK: -
fileprivate typealias Info = WRDevice
public extension Info {
    /**安全区偏移*/
    var safeAreaInset : UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if (UIApplication.shared.keyWindow != nil) {
                return (UIApplication.shared.keyWindow?.safeAreaInsets)!;
            }
        }
        return UIEdgeInsets.zero
    }
    
    /** 设备UUID*/
    var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString//UIDevice.current.uniqueDeviceIdentifier()
    }
    
    /** 设备名称*/
    var name: String {
        return UIDevice.current.name
    }

    /** 应用名称*/
    var appName: String? {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String
    }

    /** 系统版本号*/
    var systemVersion: String {
        return UIDevice.current.systemVersion
    }

    /** 应用 build 版本号*/
    var buildVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    /** 应用版本号*/
    var clientVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /** 设备id*/
    var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        var identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        if identifier == "i386" || identifier == "x86_64" {
            identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "unknown"
        }

        return identifier
    }
    
    /** 硬件*/
    var hardware: WRHardware {
        switch identifier {
        /**iPhone*/
        case "iPhone1,1":                           return .iPhone(.iPhone2G)
        case "iPhone1,2":                           return .iPhone(.iPhone3G)
        case "iPhone2,1":                           return .iPhone(.iPhone3GS)
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone(.iPhone4)
        case "iPhone4,1":                           return .iPhone(.iPhone4S)
        case "iPhone5,1", "iPhone5,2":              return .iPhone(.iPhone5)
        case "iPhone5,3", "iPhone5,4":              return .iPhone(.iPhone5c)
        case "iPhone6,1", "iPhone6,2":              return .iPhone(.iPhone5s)
        case "iPhone7,2":                           return .iPhone(.iPhone6)
        case "iPhone7,1":                           return .iPhone(.iPhone6Plus)
        case "iPhone8,1":                           return .iPhone(.iPhone6s)
        case "iPhone8,2":                           return .iPhone(.iPhone6sPlus)
        case "iPhone8,4":                           return .iPhone(.iPhoneSE1)
        case "iPhone9,1", "iPhone9,3":              return .iPhone(.iPhone7)
        case "iPhone9,2", "iPhone9,4":              return .iPhone(.iPhone7Plus)
        case "iPhone10,1", "iPhone10,4":            return .iPhone(.iPhone8)
        case "iPhone10,2", "iPhone10,5":            return .iPhone(.iPhone8Plus)
        case "iPhone10,3", "iPhone10,6":            return .iPhone(.iPhoneX)
        case "iPhone11,8":                          return .iPhone(.iPhoneXR)
        case "iPhone11,2":                          return .iPhone(.iPhoneXS)
        case "iPhone11,6", "iPhone11,4":            return .iPhone(.iPhoneXSMax)
        case "iPhone12,1":                          return .iPhone(.iPhone11)
        case "iPhone12,3":                          return .iPhone(.iPhone11Pro)
        case "iPhone12,5":                          return .iPhone(.iPhone11ProMax)
        case "iPhone12,8":                          return .iPhone(.iPhoneSE2)
        case "iPhone13,1":                          return .iPhone(.iPhone12Mini)
        case "iPhone13,2":                          return .iPhone(.iPhone12)
        case "iPhone13,3":                          return .iPhone(.iPhone12Pro)
        case "iPhone13,4":                          return .iPhone(.iPhone12ProMax)
        /**iPad*/
        case "iPad1,1":                                   return .iPad(.iPad1)
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return .iPad(.iPad2)
        case "iPad3,1", "iPad3,2", "iPad3,3":             return .iPad(.iPad3)
        case "iPad3,4", "iPad3,5", "iPad3,6":             return .iPad(.iPad4)
        case "iPad6,11", "iPad6,12":                      return .iPad(.iPad5)
        case "iPad7,5", "iPad7,6":                        return .iPad(.iPad6)
        case "iPad7,11", "iPad7,12":                      return .iPad(.iPad7)
        case "iPad11,6", "iPad11,7":                      return .iPad(.iPad8)
            
        case "iPad2,5", "iPad2,6", "iPad2,7":   return .iPad(.iPadMini_1)
        case "iPad4,4", "iPad4,5", "iPad4,6":   return .iPad(.iPadMini_2)
        case "iPad4,7", "iPad4,8", "iPad4,9":   return .iPad(.iPadMini_3)
        case "iPad5,1", "iPad5,2":              return .iPad(.iPadMini_4)
        case "iPad11,1", "iPad11,2":            return .iPad(.iPadMini_5)

        case "iPad4,1", "iPad4,2", "iPad4,3":   return .iPad(.iPadAir_1)
        case "iPad5,3", "iPad5,4":              return .iPad(.iPadAir_2)
        case "iPad11,3", "iPad11,4":            return .iPad(.iPadAir_3)
        case "iPad13,1", "iPad13,2":            return .iPad(.iPadAir_4)

        case "iPad6,3", "iPad6,4":                          return .iPad(.iPadPro_097_1)
        case "iPad6,7", "iPad6,8":                          return .iPad(.iPadPro_129_1)
        case "iPad7,1", "iPad7,2":                          return .iPad(.iPadPro_129_2)
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":    return .iPad(.iPadPro_129_3)
        case "iPad8,11", "iPad8,12":                        return .iPad(.iPadPro_129_4)
        case "iPad7,3", "iPad7,4":                          return .iPad(.iPadPro_105_1)
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":    return .iPad(.iPadPro_110_1)
        case "iPad8,9", "iPad8,10":                         return .iPad(.iPadPro_110_2)

        /**iPod Touch*/
        case "iPod1,1": return .iPodTouch(.iPodTouch1)
        case "iPod2,1": return .iPodTouch(.iPodTouch2)
        case "iPod3,1": return .iPodTouch(.iPodTouch3)
        case "iPod4,1": return .iPodTouch(.iPodTouch4)
        case "iPod5,1": return .iPodTouch(.iPodTouch5)
        case "iPod7,1": return .iPodTouch(.iPodTouch6)
        case "iPod9,1": return .iPodTouch(.iPodTouch7)
            
        /**Apple Watch*/
        case "Watch1,1", "Watch1,2":                            return .AppleWatch(.AppleWatch_1)
        case "Watch2,6", "Watch2,7":                            return .AppleWatch(.AppleWatchSeries_1)
        case "Watch2,3", "Watch2,4":                            return .AppleWatch(.AppleWatchSeries_2)
        case "Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4":    return .AppleWatch(.AppleWatchSeries_3)
        case "Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4":    return .AppleWatch(.AppleWatchSeries_4)
        case "Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4":    return .AppleWatch(.AppleWatchSeries_5)
        case "Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4":    return .AppleWatch(.AppleWatchSeries_6)
        case "Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12": return .AppleWatch(.AppleWatchSE)

        /**Apple TV*/
        case "AppleTV1,1":                  return .AppleTV(.AppleTV_1)
        case "AppleTV2,1":                  return .AppleTV(.AppleTV_2)
        case "AppleTV3,1", "AppleTV3,2":    return .AppleTV(.AppleTV_3)
        case "AppleTV5,3":                  return .AppleTV(.AppleTV_4)
        case "AppleTV6,2":                  return .AppleTV(.AppleTV4K)

        default: return .unknown
        }
    }
}

//MARK: -
fileprivate typealias Language = WRDevice
public extension Language {
    /** 检查系统支持语言*/
    func supportLanguage(_ languages : [String]) -> Bool {
        
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

    /** 检查系统中文*/
    var isChinese: Bool {
        return supportLanguage(["zh-Hans", "zh-Hant"])
    }
    
    /** 当前设备语言*/
    var currentLanguage: String? {
        return UserDefaults.standard.object(forKey: "AppleLanguages") as? String
    }
}

//MARK: -
fileprivate typealias Space = WRDevice
public extension Space {
    enum Space {
        /** 空闲 */
        case free
        
        /** 总计 */
        case total
                
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
            case .free: return String(format: "%.2fGB", WRDevice.DoubleGbSpace(space: self.value))
            case .total: return WRDevice.CalculateDeviceSpace(spaceGb: self.value)
            }
        }
    }
    
    private static func DoubleGbSpace(space: Double) -> Double {
        return space / 1024.0 / 1024.0 / 1024.0
    }
    
    private static func CalculateDeviceSpace(spaceGb: Double) -> String {
        
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
    
    func spaceValue(_ space : Space) -> Double {
        guard let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else{
            return 0
        }

        switch space{
        case .free: return Double((attributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.uint64Value ?? 0)
        case .total: return attributes[FileAttributeKey.systemSize] as? Double ?? 0
        }
    }

    func gbString(_ space : Space) -> String {
        switch space{
        case .free: return String(format: "%.2fGB", WRDevice.DoubleGbSpace(space: space.value))
        case .total: return WRDevice.CalculateDeviceSpace(spaceGb: space.value)
        }
    }

}

//MARK: -
fileprivate typealias Sensor = WRDevice
public extension Sensor {
    //屏幕亮度
    func setBrightness(_ brightnessValue : CGFloat){
        UIScreen.main.brightness = brightnessValue
    }
    
    //感应黑屏
    func setProximityMonitoringEnabled(enabled : Bool){
        UIDevice.current.isProximityMonitoringEnabled = enabled
    }
}
