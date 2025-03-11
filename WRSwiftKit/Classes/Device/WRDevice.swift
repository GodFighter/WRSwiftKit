//
//  WRDevice.swift
//  Pods-WRKit_Example
//
//  Created by xianghui-iMac on 2020/1/13.
//

import UIKit
import CoreTelephony
import SystemConfiguration.CaptiveNetwork

@objc public class WRDevice: NSObject {
    
    @objc public static let Shared: WRDevice = {
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

    var isSimulator: Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    var isBroken: Bool {
        let testFilePath = "/private/jailbreak_test.txt"
        do {
            try "test".write(toFile: testFilePath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testFilePath)
            return true  // 写入成功，可能是越狱设备
        } catch {
            return false // 写入失败，正常设备
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

    /** 时区*/
    var timeZone: String? {
        let totalSeconds = TimeZone.current.secondsFromGMT()
        let symbol = totalSeconds >= 0 ? "+" : "-"
        let absoluteSeconds = abs(totalSeconds)
        let hours = absoluteSeconds / 3600
        let minutes = (absoluteSeconds % 3600) / 60
        
        if hours == 0 && minutes == 0 {
            return nil
        } else {
            var timeZoneString = "GMT\(symbol)\(hours)"
            if minutes != 0 {
                timeZoneString += String(format: ":%02d", minutes)
            }
            return timeZoneString
        }
    }
    
    /** 电量百分比*/
    var batteryPercentage: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(abs(UIDevice.current.batteryLevel) * 100)
    }

    /** 是否充电*/
    var batteryCharging: Bool {
        switch UIDevice.current.batteryState {
        case .charging, .full:
            return true
        case .unplugged, .unknown:
            return false
        @unknown default:
            return false
        }
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
        case "iPhone12,8":                          return .iPhone(.iPhoneSE2)
        case "iPhone14,6":                          return .iPhone(.iPhoneSE3)

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
            
        case "iPhone13,1":                          return .iPhone(.iPhone12Mini)
        case "iPhone13,2":                          return .iPhone(.iPhone12)
        case "iPhone13,3":                          return .iPhone(.iPhone12Pro)
        case "iPhone13,4":                          return .iPhone(.iPhone12ProMax)

        case "iPhone14,2":                          return .iPhone(.iPhone13Pro)
        case "iPhone14,3":                          return .iPhone(.iPhone13ProMax)
        case "iPhone14,4":                          return .iPhone(.iPhone13Mini)
        case "iPhone14,5":                          return .iPhone(.iPhone13)
            
        case "iPhone14,7":                          return .iPhone(.iPhone14)
        case "iPhone14,8":                          return .iPhone(.iPhone14Plus)
        case "iPhone15,2":                          return .iPhone(.iPhone14Pro)
        case "iPhone15,3":                          return .iPhone(.iPhone14ProMax)

        case "iPhone15,4":                          return .iPhone(.iPhone15)
        case "iPhone15,5":                          return .iPhone(.iPhone15Plus)
        case "iPhone16,1":                          return .iPhone(.iPhone15Pro)
        case "iPhone16,2":                          return .iPhone(.iPhone15ProMax)

        case "iPhone17,3":                          return .iPhone(.iPhone16)
        case "iPhone17,4":                          return .iPhone(.iPhone16Plus)
        case "iPhone17,1":                          return .iPhone(.iPhone16Pro)
        case "iPhone17,2":                          return .iPhone(.iPhone16ProMax)
        case "iPhone17,5":                          return .iPhone(.iPhone16e)

            /**iPad*/
        case "iPad1,1":                                   return .iPad(.iPad1)
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return .iPad(.iPad2)
        case "iPad3,1", "iPad3,2", "iPad3,3":             return .iPad(.iPad3)
        case "iPad3,4", "iPad3,5", "iPad3,6":             return .iPad(.iPad4)
        case "iPad6,11", "iPad6,12":                      return .iPad(.iPad5)
        case "iPad7,5", "iPad7,6":                        return .iPad(.iPad6)
        case "iPad7,11", "iPad7,12":                      return .iPad(.iPad7)
        case "iPad11,6", "iPad11,7":                      return .iPad(.iPad8)
        case "iPad12,1", "iPad12,2":                      return .iPad(.iPad9)
        case "iPad13,18", "iPad13,19":                    return .iPad(.iPad10)
        case "iPad15,7", "iPad15,8":                      return .iPad(.iPad_a16)

        case "iPad2,5", "iPad2,6", "iPad2,7":   return .iPad(.iPadMini_1)
        case "iPad4,4", "iPad4,5", "iPad4,6":   return .iPad(.iPadMini_2)
        case "iPad4,7", "iPad4,8", "iPad4,9":   return .iPad(.iPadMini_3)
        case "iPad5,1", "iPad5,2":              return .iPad(.iPadMini_4)
        case "iPad11,1", "iPad11,2":            return .iPad(.iPadMini_5)
        case "iPad14,1", "iPad14,2":            return .iPad(.iPadMini_6)
        case "iPad16,1", "iPad16,2":            return .iPad(.iPadMini_a17_pro)

        case "iPad4,1", "iPad4,2", "iPad4,3":   return .iPad(.iPadAir_1)
        case "iPad5,3", "iPad5,4":              return .iPad(.iPadAir_2)
        case "iPad11,3", "iPad11,4":            return .iPad(.iPadAir_3)
        case "iPad13,1", "iPad13,2":            return .iPad(.iPadAir_4)
        case "iPad13,16", "iPad13,17":          return .iPad(.iPadAir_5)
        case "iPad14,8", "iPad14,9":            return .iPad(.iPadAir_11_m2)
        case "iPad14,10", "iPad14,11":          return .iPad(.iPadAir_13_m2)
        case "iPad15,3", "iPad15,4":            return .iPad(.iPadAir_11_m3)
        case "iPad15,5", "iPad15,6":            return .iPad(.iPadAir_13_m3)

        case "iPad6,3", "iPad6,4":                              return .iPad(.iPadPro_097_1)
        case "iPad6,7", "iPad6,8":                              return .iPad(.iPadPro_129_1)
        case "iPad7,1", "iPad7,2":                              return .iPad(.iPadPro_129_2)
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":        return .iPad(.iPadPro_129_3)
        case "iPad8,11", "iPad8,12":                            return .iPad(.iPadPro_129_4)
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":  return .iPad(.iPadPro_129_5)
        case "iPad7,3", "iPad7,4":                              return .iPad(.iPadPro_105_1)
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":        return .iPad(.iPadPro_110_1)
        case "iPad8,9", "iPad8,10":                             return .iPad(.iPadPro_110_2)
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":    return .iPad(.iPadPro_110_3)
//        case "unknown":    return .iPad(.iPadPro_110_4)
//        case "unknown":    return .iPad(.iPadPro_129_6)
        case "iPad16,3", "iPad16,4":                            return .iPad(.iPadPro_110_m4)
        case "iPad16,5", "iPad16,6":                            return .iPad(.iPadPro_130_m4)

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
        case "Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9":    return .AppleWatch(.AppleWatchSeries_7)
        case "Watch6,10", "Watch6,11", "Watch6,12", "Watch6,13": return .AppleWatch(.AppleWatchSE)
        case "Watch6,16", "Watch6,17":                          return .AppleWatch(.AppleWatchSeries_8)
        case "Watch6,18":                                       return .AppleWatch(.AppleWatchUltra_1)
        case "Watch7,1", "Watch7,2", "Watch7,3", "Watch7,4":    return .AppleWatch(.AppleWatchSeries_9)
        case "Watch7,5":                                        return .AppleWatch(.AppleWatchUltra_2)
        case "Watch7,8", "Watch7,9", "Watch7,10", "Watch7,11":  return .AppleWatch(.AppleWatchSeries_10)

        /**Apple TV*/
        case "AppleTV1,1":                  return .AppleTV(.AppleTV_1)
        case "AppleTV2,1":                  return .AppleTV(.AppleTV_2)
        case "AppleTV3,1", "AppleTV3,2":    return .AppleTV(.AppleTV_3)
        case "AppleTV5,3":                  return .AppleTV(.AppleTV_HD)
        case "AppleTV6,2":                  return .AppleTV(.AppleTV4K_1)
        case "AppleTV11,1":                 return .AppleTV(.AppleTV4K_2)
        case "AppleTV14,1":                 return .AppleTV(.AppleTV4K_3)

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

//MARK: - 存储
fileprivate typealias Storage = WRDevice
public extension Storage {
    enum Storage {
        /** 空闲 */
        case free
        /** 总计 */
        case total
    }
}

public extension WRDevice.Storage {
    var value : Double {
        guard let attributes  = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else{
            return 0
        }
        
        switch self{
        case .free: return Double((attributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.uint64Value ?? 0)
        case .total: return attributes[FileAttributeKey.systemSize] as? Double ?? 0
        }
    }
    
    var description : String {
        switch self{
        case .free: return WRFolder.Target(size: Float(self.value), range: 2)
        case .total: return WRFolder.Target(ceil: Float(self.value))
        }
    }
}

//MARK: - 内存
fileprivate typealias Memory = WRDevice
public extension Memory {
    enum Memory {
        /** 空闲 */
        case free
        /** 总计 */
        case total
    }
}

public extension WRDevice.Memory {
    var value : Int {
        guard let _ = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else {
            return 0
        }
        
        switch self {
        case .free:
            var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size)/4
            var vmStats = vm_statistics_data_t()
            let result = withUnsafeMutablePointer(to: &vmStats) {
                $0.withMemoryRebound(to: integer_t.self, capacity: 1) { ptr in
                    host_statistics(mach_host_self(), HOST_VM_INFO, ptr, &count)
                }
            }
            guard result == KERN_SUCCESS else { return 0 }
            let freeCount = Int(vmStats.free_count) &+ Int(vmStats.inactive_count)
            return freeCount * Int(vm_page_size)
        case .total:
            return Int(ProcessInfo.processInfo.physicalMemory)
        }
    }
    
    var description: String {
        switch self{
        case .free: return WRFolder.Target(size: Float(self.value), range: 2)
        case .total: return WRFolder.Target(ceil: Float(self.value)) 
        }
    }
}

//MARK: -
fileprivate typealias Sensor = WRDevice
public extension Sensor {
    //屏幕亮度
    func setBrightness(_ brightnessValue : CGFloat) {
        UIScreen.main.brightness = brightnessValue
    }
    
    //感应黑屏
    func setProximityMonitoringEnabled(enabled : Bool) {
        UIDevice.current.isProximityMonitoringEnabled = enabled
    }
}

//MARK: -
fileprivate typealias Wifi = WRDevice
public extension Wifi {
    /** wifi 信息*/
    var wifi: (ssid: String?, bssid: String?) {
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            for interface in interfaces {
                let interfaceName = interface as! String
                if let dict = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? {
                    return (dict[kCNNetworkInfoKeySSID as String] as? String,
                            dict[kCNNetworkInfoKeyBSSID as String] as? String)
                }
            }
        }
        return (nil, nil)
    }
    
    /** ip信息*/
    var ip: String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let flags = Int32(ptr!.pointee.ifa_flags)
                let family = ptr!.pointee.ifa_addr.pointee.sa_family
                
                if family == AF_INET && (flags & (IFF_UP | IFF_RUNNING)) != 0 {
                    var addr = ptr!.pointee.ifa_addr.pointee
                    var addrString = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(&addr, socklen_t(addr.sa_len), &addrString, socklen_t(addrString.count), nil, 0, NI_NUMERICHOST) == 0 {
                        address = String(cString: addrString)
                    }
                }
                ptr = ptr!.pointee.ifa_next
             }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    /** 是否使用代理*/
    var usedProxy: Bool {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else {
            return false
        }
        guard let info = proxy as? [String : Any] else {
            return false
        }
        guard let HTTPProxy = info["HTTPProxy"] as? String else {
            return false
        }
        if HTTPProxy.count > 0 {
            return true
        }
        
        return false
    }
    
    /** 是否使用VPN*/
    var usedVPN: Bool {
        guard let settings = CFNetworkCopySystemProxySettings() else {
            return false
        }

        guard let info = settings.takeRetainedValue() as? [String : Any] else {
            return false
        }
        guard let keys = info["__SCOPED__"] as? [String : Any] else {
            return false
        }
        
        let regex = ["tap", "tun", "ppp", "ipsec", "ipsec0"]
        
        var result: Bool = false
        for key in keys.keys {
            regex.forEach { (value) in
                if key.contains(value) {
                    result = true
                }
            }
        }
        return result
    }
    
    /** 是否破解*/
    var isJailBroken: Bool {
        let testFilePath = "/private/jailbreak_test.txt"
        do {
            try "test".write(toFile: testFilePath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testFilePath)
            return true  // 写入成功，可能是越狱设备
        } catch {
            return false // 写入失败，正常设备
        }
    }
    
    /** 运营商*/
    var cellularProviders: String? {
        guard #available(iOS 12.0, *) else {
            return nil
        }
        let networkInfo = CTTelephonyNetworkInfo()
        guard let providers = networkInfo.serviceSubscriberCellularProviders,
              let carrier = providers.values.first(where: { $0.carrierName != nil }) else {
            return nil
        }
        return carrier.carrierName
    }
    
    /** 网络类型*/
    var networkKind: String? {
        let networkInfo = CTTelephonyNetworkInfo()
        guard #available(iOS 12.0, *) else {
            return nil
        }
        guard let technology = networkInfo.serviceCurrentRadioAccessTechnology?.values.first else {
            return nil
        }

        if #available(iOS 14.1, *) {
            if technology == CTRadioAccessTechnologyNR || technology == CTRadioAccessTechnologyNRNSA {
                return "5G"
            }
        }

        switch technology {
        case CTRadioAccessTechnologyGPRS: return "2G"
        case CTRadioAccessTechnologyEdge: return "2G"
        case CTRadioAccessTechnologyLTE: return "4G"
        default: return nil
        }
   }
    
}
