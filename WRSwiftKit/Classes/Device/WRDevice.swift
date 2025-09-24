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
    
    @objc public static let current: WRDevice = {
        let shared = WRDevice()
        return shared
    }()
        
    /** 硬件*/
    internal var hardware: WRHardware {
        return WRHardware(identifier)
    }
    
}

//MARK: - Judge
@objc public extension WRDevice {
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

//MARK: - Info
@objc public extension WRDevice {
    /** 设备名称*/
    var name: String {
        return UIDevice.current.name
    }

    /** 设备型号*/
    var model: String {
        return hardware.name
    }
    
    /** 设备尺寸*/
    var size: CGSize {
        return hardware.size
    }
    
    /** 设备对角线英寸*/
    var inches: CGFloat {
        return hardware.inches
    }
    
    /** 设备分辨率*/
    var resolution: CGSize {
        return hardware.resolution
    }
    
    /** 系统名*/
    var systemName: String {
        return hardware.systemName ?? "iOS"
    }

    /** 设备UUID*/
    var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString//UIDevice.current.uniqueDeviceIdentifier()
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

    /**安全区偏移*/
    var safeAreaInset : UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if (UIApplication.shared.keyWindow != nil) {
                return (UIApplication.shared.keyWindow?.safeAreaInsets)!;
            }
        }
        return UIEdgeInsets.zero
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
        
        if identifier == "i386" || identifier == "x86_64" || identifier == "arm64" {
            identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "unknown"
        }

        return identifier
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
    
    /** 运营商*/
    var cellularKind: String? {
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

//MARK: - Language
@objc public extension WRDevice {
    /** 检查系统支持语言*/
    func supportLanguage(_ languages : [String]) -> Bool {
        var allLanguages: [String] = []
        if #available(iOS 16, *) {
            allLanguages = Locale.preferredLanguages
        } else {
            let defaults = UserDefaults.standard
            if let all : [String] = defaults.object(forKey: "AppleLanguages") as? [String]{
                allLanguages = all
            }
        }
        
        let preferLanguage = allLanguages[0]
        let range : Range<String.Index> = preferLanguage.startIndex ..< preferLanguage.endIndex
        for language in languages{
            
            if (preferLanguage.range(of: language, options: String.CompareOptions.caseInsensitive, range: range, locale: nil) != nil){
                return true
            }
        }
        
        return false
    }

    /** 检查系统中文*/
    var isChinese: Bool {
        return supportLanguage(["zh-Hans", "zh-Hant"])
    }
    
    /** 当前设备语言*/
    var language: String? {
        if #available(iOS 16, *) {
            return Locale.preferredLanguages.first
        } else {
            if let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] {
                return languages.first
            }
            return nil
        }
    }
    
    var languageCode: String? {
//        let a : [String : Any] = [
//            "preferredLanguages": Locale.preferredLanguages, // ["zh-Hans-CN", "en-CN"]
//            "firstPreferredLanguage": Locale.preferredLanguages.first ?? "未知", // zh-Hans-CN
//            "currentLanguageCode": Locale.current.languageCode ?? "未知", //en
//            "currentRegionCode": Locale.current.regionCode ?? "未知", // CN
//            "currentIdentifier": Locale.current.identifier, //en_CN
//            "currentCurrencyCode": Locale.current.currencyCode ?? "未知", // CNY
//            "currentCalendar": Locale.current.calendar.identifier // gregorian
//        ]
//        print(a)

        return Locale.current.regionCode
    }
}

//MARK: - Storage
public extension WRDevice {
    @objc enum Storage: Int {
        /** 空闲 */
        case free
        /** 总计 */
        case total
    }
    
    @objc func storageValue(_ storage: WRDevice.Storage) -> Double {
        guard let attributes  = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else{
            return 0
        }
        switch storage {
        case .free:
            return Double((attributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.uint64Value ?? 0)
        case .total:
            return attributes[FileAttributeKey.systemSize] as? Double ?? 0
        }
    }
    
    @objc func storageString(_ storage: WRDevice.Storage) -> String {
        switch storage {
        case .free: return WRFolder.Target(size: Float(WRDevice.current.storageValue(storage)), range: 2)
        case .total: return WRFolder.Target(ceil: Float(WRDevice.current.storageValue(storage)))
        }
    }
}

//MARK: - Memory
public extension WRDevice {
    @objc enum Memory: Int {
        /** 空闲 */
        case free
        /** 总计 */
        case total
    }
    
    @objc func memoryValue(_ memory: WRDevice.Memory) -> Int {
        guard let _ = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else {
            return 0
        }
        
        switch memory {
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
    
    @objc func memoryString(_ memory: WRDevice.Memory) -> String {
        switch memory {
        case .free: return WRFolder.Target(size: Float(memoryValue(memory)), range: 2)
        case .total: return WRFolder.Target(ceil: Float(memoryValue(memory)))
        }
    }
}

//MARK: - Sensor
public extension WRDevice {
    //屏幕亮度
    @objc func setBrightness(_ brightnessValue : CGFloat) {
        UIScreen.main.brightness = brightnessValue
    }
    
    //感应黑屏
    @objc func setProximityMonitoringEnabled(enabled : Bool) {
        UIDevice.current.isProximityMonitoringEnabled = enabled
    }
}

//MARK: - Wifi
public extension WRDevice {
    /** wifi 信息
     [ssid: String?, bssid: String?]
     */
    @objc var wifi: [String : String] {
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            for interface in interfaces {
                let interfaceName = interface as! String
                if let dict = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? {
                    return ["SSID" : dict[kCNNetworkInfoKeySSID as String] as? String ?? "",
                            "BSSID" : dict[kCNNetworkInfoKeyBSSID as String] as? String ?? ""]
                }
            }
        }
        return [:]
    }
    
    /** ip信息*/
    @objc var ip: String? {
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
    @objc var usedProxy: Bool {
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
    @objc var usedVPN: Bool {
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
        
    @objc var isWifi: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let isWiFi = (isReachable && !needsConnection)
        
        return isWiFi
    }
    
}
