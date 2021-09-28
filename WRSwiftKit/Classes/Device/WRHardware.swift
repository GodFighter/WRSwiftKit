//
//  WRDeviceType.swift
//  WRSwiftKit
//
//  Created by 项辉 on 2021/4/17.
//

import Foundation


/** 设备尺寸*/
protocol WRDeviceSize {
    var size: CGSize { get }
}

/**设备倍数*/
protocol WRScale {
    var scale: CGFloat { get }
}

/** 设备分辨率*/
protocol WRResolution: WRDeviceSize, WRScale {
    var resolution: CGSize { get }
}

public enum WRHardware {
    
    case unknown
    
    //MARK:-
    public enum iPhones: String, WRResolution {
        case iPhone         = "iPhone"
        
        case iPhone2G       = "iPhone 2G"
        case iPhone3G       = "iPhone 3G"
        case iPhone3GS      = "iPhone 3GS"
        case iPhone4        = "iPhone 4"
        case iPhone4S       = "iPhone 4s"
        case iPhone5        = "iPhone 5"
        case iPhone5c       = "iPhone 5c"
        case iPhone5s       = "iPhone 5s"
        case iPhone6        = "iPhone 6"
        case iPhone6Plus    = "iPhone 6 Plus"
        case iPhone6s       = "iPhone 6s"
        case iPhone6sPlus   = "iPhone 6s Plus"
        case iPhoneSE1      = "iPhone SE 1"
        case iPhoneSE2      = "iPhone SE 2"
        case iPhone7        = "iPhone 7"
        case iPhone7Plus    = "iPhone 5 Plus"
        case iPhone8        = "iPhone 8"
        case iPhone8Plus    = "iPhone 8 Plus"
        case iPhoneX        = "iPhone X"
        case iPhoneXR       = "iPhone XR"
        case iPhoneXS       = "iPhone XS"
        case iPhoneXSMax    = "iPhone XS Max"
        case iPhone11       = "iPhone 11"
        case iPhone11Pro    = "iPhone 11 Pro"
        case iPhone11ProMax = "iPhone 11 Pro Max"
        case iPhone12Mini   = "iPhone 12 mini"
        case iPhone12       = "iPhone 12"
        case iPhone12Pro    = "iPhone 12 Pro"
        case iPhone12ProMax = "iPhone 12 Pro Max"
        
        case iPhone13Mini   = "iPhone 13 mini"
        case iPhone13       = "iPhone 13"
        case iPhone13Pro    = "iPhone 13 Pro"
        case iPhone13ProMax = "iPhone 13 Pro Max"

        var size: CGSize {
            switch self {
            case .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4, .iPhone4S:    return CGSize(width: 320, height: 480)
            case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE1:               return CGSize(width: 320, height: 568)
            case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2:      return CGSize(width: 375, height: 667)
            case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:  return CGSize(width: 414, height:736)
            case .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone13Mini:         return CGSize(width: 375, height: 812)
            case .iPhone11, .iPhoneXR, .iPhone11ProMax, .iPhoneXSMax:      return CGSize(width: 414, height: 896)
            case .iPhone12Mini:                                            return CGSize(width: 360, height: 780)
            case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro:         return CGSize(width: 390, height: 844)
            case .iPhone12ProMax, .iPhone13ProMax:                         return CGSize(width: 428, height: 926)
            default: return .zero
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .iPhone2G, .iPhone3G, .iPhone3GS:
                return 1.0
                
            case .iPhone4, .iPhone4S,
                 .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE1,
                 .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2,
                 .iPhone11, .iPhoneXR:
                return 2.0
                
            case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus,
                 .iPhoneX, .iPhoneXS, .iPhone11Pro,
                 .iPhoneXSMax, .iPhone11ProMax,
                 .iPhone12, .iPhone12Pro,
                 .iPhone12Mini,
                 .iPhone12ProMax:
                return 3.0
                
            default: return 0
            }
        }
        
        var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
    }
    case iPhone(iPhones)

    //MARK:-
    public enum iPads: String, WRResolution {
        case iPad = "iPad"
        
        case iPad1 = "iPad 1"
        case iPad2 = "iPad 2"
        case iPad3 = "iPad 3"
        case iPad4 = "iPad 4"
        case iPad5 = "iPad 5"
        case iPad6 = "iPad 6"
        case iPad7 = "iPad 7"
        case iPad8 = "iPad 8"
        case iPad9 = "iPad 9"

        case iPadAir_1 = "iPad Air 1"
        case iPadAir_2 = "iPad Air 2"
        case iPadAir_3 = "iPad Air 3"
        case iPadAir_4 = "iPad Air 4"
        
        case iPadMini_1 = "iPad mini 1"
        case iPadMini_2 = "iPad mini 2"
        case iPadMini_3 = "iPad mini 3"
        case iPadMini_4 = "iPad mini 4"
        case iPadMini_5 = "iPad mini 5"
        case iPadMini_6 = "iPad mini 6"

        case iPadPro_129_1 = "iPad Pro 12.9 1"
        case iPadPro_129_2 = "iPad Pro 12.9 2"
        case iPadPro_129_3 = "iPad Pro 12.9 3"
        case iPadPro_129_4 = "iPad Pro 12.9 4"
        case iPadPro_129_5 = "iPad Pro 12.9 5"
        case iPadPro_097_1 = "iPad Pro 9.7 1"
        case iPadPro_105_1 = "iPad Pro 10.5 1"
        case iPadPro_110_1 = "iPad Pro 11.0 1"
        case iPadPro_110_2 = "iPad Pro 11.0 2"
        case iPadPro_110_3 = "iPad Pro 11.0 3"

        var size: CGSize {
            switch self {
            case .iPad1, .iPad2, .iPad3, .iPad4, .iPad5, .iPad6,
                 .iPadAir_1, .iPadAir_2,
                 .iPadMini_1, .iPadMini_2, .iPadMini_3, .iPadMini_4, .iPadMini_5,
                 .iPadPro_097_1:                                                    return CGSize(width: 768, height: 1024)
            case .iPad7, .iPad8, .iPad9:                                            return CGSize(width: 810, height: 1080)
            case .iPadAir_3,
                 .iPadPro_105_1:                                                    return CGSize(width: 834, height: 1112)
            case .iPadAir_4:                                                        return CGSize(width: 820, height: 1180)

            case .iPadPro_129_1,
                    .iPadPro_129_2,
                    .iPadPro_129_3,
                    .iPadPro_129_4,
                    .iPadPro_129_5:                                                 return CGSize(width: 1024, height: 1366)
            case .iPadPro_110_1, .iPadPro_110_2, .iPadPro_110_3:                    return CGSize(width: 834, height: 1194)

            case .iPadMini_6:                                                        return CGSize(width: 744, height: 1133);
            default: return .zero
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .iPad1, .iPad2:
                return 1.0
            default: return 2.0
            }
        }
        
        var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
   }
    case iPad(iPads)
    
    //MARK:-
    public enum iPodTouchs: Int, WRResolution {
        case iPodTouch = 300
        
        case iPodTouch1
        case iPodTouch2
        case iPodTouch3
        case iPodTouch4
        case iPodTouch5
        case iPodTouch6
        case iPodTouch7
        
        var size: CGSize {
            switch self {
            case .iPodTouch1, .iPodTouch2, .iPodTouch3, .iPodTouch4:    return CGSize(width: 320, height: 480)
            case .iPodTouch5, .iPodTouch6, .iPodTouch7:                 return CGSize(width: 320, height: 568)
            default: return .zero
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .iPodTouch1, .iPodTouch2, .iPodTouch3:
                return 1.0
            default: return 2.0
            }
        }
        
        var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
    }
    case iPodTouch(iPodTouchs)

    //MARK:-
    public enum AppleWatchs: Int {
        case AppleWatch = 400
        
        case AppleWatch_1

        case AppleWatchSeries_1
        case AppleWatchSeries_2
        case AppleWatchSeries_3
        case AppleWatchSeries_4
        case AppleWatchSeries_5
        case AppleWatchSeries_6

        case AppleWatchSE
    }
    case AppleWatch(AppleWatchs)

    //MARK:-
    public enum AppleTVs: Int {
        case AppleTV = 500
        
        case AppleTV_1
        case AppleTV_2
        case AppleTV_3
        case AppleTV_4

        case AppleTV4K_1
        case AppleTV4K_2
    }
    case AppleTV(AppleTVs)

}
