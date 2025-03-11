//
//  WRDeviceType.swift
//  WRSwiftKit
//
//  Created by 项辉 on 2021/4/17.
//

import Foundation

//MARK: -
public enum WRHardware {
    
    case unknown
    case iPhone(iPhones)
    case iPad(iPads)
    case iPodTouch(iPodTouchs)
    case AppleWatch(AppleWatchs)
    case AppleTV(AppleTVs)

    //MARK:-
    public enum iPhones: String, WRResolution {
        case iPhone = "iPhone"
        
        case iPhone2G = "iPhone 2G"
        
        case iPhone3G  = "iPhone 3G"
        case iPhone3GS = "iPhone 3GS"
        
        case iPhone4  = "iPhone 4"
        case iPhone4S = "iPhone 4s"
        
        case iPhone5  = "iPhone 5"
        case iPhone5c = "iPhone 5c"
        case iPhone5s = "iPhone 5s"
        
        case iPhone6      = "iPhone 6"
        case iPhone6Plus  = "iPhone 6 Plus"
        case iPhone6s     = "iPhone 6s"
        case iPhone6sPlus = "iPhone 6s Plus"
        
        case iPhoneSE1 = "iPhone SE 1"
        case iPhoneSE2 = "iPhone SE 2"
        case iPhoneSE3 = "iPhone SE 3"

        case iPhone7     = "iPhone 7"
        case iPhone7Plus = "iPhone 5 Plus"
        
        case iPhone8     = "iPhone 8"
        case iPhone8Plus = "iPhone 8 Plus"
        
        case iPhoneX     = "iPhone X"
        case iPhoneXR    = "iPhone XR"
        case iPhoneXS    = "iPhone XS"
        case iPhoneXSMax = "iPhone XS Max"
        
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

        case iPhone14       = "iPhone 14"
        case iPhone14Plus   = "iPhone 14 Plus"
        case iPhone14Pro    = "iPhone 14 Pro"
        case iPhone14ProMax = "iPhone 14 Pro Max"

        case iPhone15       = "iPhone 15"
        case iPhone15Plus   = "iPhone 15 Plus"
        case iPhone15Pro    = "iPhone 15 Pro"
        case iPhone15ProMax = "iPhone 15 Pro Max"

        case iPhone16       = "iPhone 16"
        case iPhone16Plus   = "iPhone 16 Plus"
        case iPhone16Pro    = "iPhone 16 Pro"
        case iPhone16ProMax = "iPhone 16 Pro Max"
        case iPhone16e      = "iPhone 16e"

        public var size: CGSize {
            switch self {
            case .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4, .iPhone4S:
                return CGSize(width: 320, height: 480)
                
            case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE1:
                return CGSize(width: 320, height: 568)
                
            case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneSE3:
                return CGSize(width: 375, height: 667)
                
            case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
                return CGSize(width: 414, height:736)
                
            case .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone13Mini:
                return CGSize(width: 375, height: 812)
                
            case .iPhone11, .iPhoneXR, .iPhone11ProMax, .iPhoneXSMax:
                return CGSize(width: 414, height: 896)
                
            case .iPhone12Mini:
                return CGSize(width: 360, height: 780)
                
            case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro, .iPhone14:
                return CGSize(width: 390, height: 844)
                
            case .iPhone14Pro, .iPhone15, .iPhone15Pro, .iPhone16, .iPhone16e:
                return CGSize(width: 393, height: 852)

            case .iPhone16Pro:
                return CGSize(width: 402, height: 874)

            case .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus:
                return CGSize(width: 428, height: 926)
                
            case .iPhone14ProMax, .iPhone15Plus, .iPhone15ProMax, .iPhone16Plus:
                return CGSize(width: 430, height: 832)

            case .iPhone16ProMax:
                return CGSize(width: 440, height: 956)

            case .iPhone:
                let size = UIScreen.main.bounds.size
                return CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
            }
        }
        
        private var scale: CGFloat {
            return UIScreen.main.scale
        }
        
        public var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
    }

    //MARK:-
    public enum iPads: String, WRResolution {
        case iPad = "iPad"
        
        case iPad1    = "iPad 1"
        case iPad2    = "iPad 2"
        case iPad3    = "iPad (3rd generation)"
        case iPad4    = "iPad (4rd generation)"
        case iPad5    = "iPad (5rd generation)"
        case iPad6    = "iPad (6rd generation)"
        case iPad7    = "iPad (7rd generation)"
        case iPad8    = "iPad (8rd generation)"
        case iPad9    = "iPad (9rd generation)"
        case iPad10   = "iPad (10rd generation)"
        case iPad_a16 = "iPad (A16)"

        case iPadAir_1     = "iPad Air 1"
        case iPadAir_2     = "iPad Air 2"
        case iPadAir_3     = "iPad Air (3rd generation)"
        case iPadAir_4     = "iPad Air (4th generation)"
        case iPadAir_5     = "iPad Air (5th generation)"
        case iPadAir_11_m2 = "iPad Air 11-inch(M2)"
        case iPadAir_13_m2 = "iPad Air 13-inch(M2)"
        case iPadAir_11_m3 = "iPad Air 11-inch(M3)"
        case iPadAir_13_m3 = "iPad Air 13-inch(M3)"

        case iPadMini_1       = "iPad mini 1"
        case iPadMini_2       = "iPad mini 2"
        case iPadMini_3       = "iPad mini 3"
        case iPadMini_4       = "iPad mini 4"
        case iPadMini_5       = "iPad mini (5th generation)"
        case iPadMini_6       = "iPad mini (6th generation)"
        case iPadMini_a17_pro = "iPad mini (A17 Pro)"

        case iPadPro_129_1 = "iPad Pro (12.9-inch)(1th generation)"
        case iPadPro_129_2 = "iPad Pro (12.9-inch)(2th generation)"
        case iPadPro_129_3 = "iPad Pro (12.9-inch)(3th generation)"
        case iPadPro_129_4 = "iPad Pro (12.9-inch)(4th generation)"
        case iPadPro_129_5 = "iPad Pro (12.9-inch)(5th generation)"
        case iPadPro_129_6 = "iPad Pro (12.9-inch)(6th generation)"

        case iPadPro_097_1  = "iPad Pro (9.7-inch)(1th generation)"
        
        case iPadPro_105_1  = "iPad Pro (10.5-inch)(1th generation)"
        
        case iPadPro_110_1  = "iPad Pro (11-inch)(1th generation)"
        case iPadPro_110_2  = "iPad Pro (11-inch)(2th generation)"
        case iPadPro_110_3  = "iPad Pro (11-inch)(3th generation)"
        case iPadPro_110_4  = "iPad Pro (11-inch)(4th generation)"
        case iPadPro_110_m4 = "iPad Pro 11-inch(M4)"
        case iPadPro_130_m4 = "iPad Pro 13-inch(M4)"

        public var size: CGSize {
            switch self {
            case .iPadMini_6, .iPadMini_a17_pro:
                return CGSize(width: 744, height: 1133);
                
            case .iPad1, .iPad2, .iPad3, .iPad4, .iPad5, .iPad6,
                 .iPadAir_1, .iPadAir_2,
                 .iPadMini_1, .iPadMini_2, .iPadMini_3, .iPadMini_4, .iPadMini_5,
                 .iPadPro_097_1:
                return CGSize(width: 768, height: 1024)
                
            case .iPad7, .iPad8, .iPad9,
                    .iPadAir_4, .iPadAir_5:
                return CGSize(width: 810, height: 1080)
                
            case .iPad10, .iPad_a16,
                    .iPadAir_11_m2, .iPadAir_11_m3:
                return CGSize(width: 820, height: 1180)

            case .iPadAir_3,
                 .iPadPro_105_1:
                return CGSize(width: 834, height: 1112)
                
            case .iPadPro_110_1, .iPadPro_110_2, .iPadPro_110_3, .iPadPro_110_4:
                return CGSize(width: 834, height: 1194)

            case .iPadPro_110_m4:
                return CGSize(width: 844, height: 1210);

            case .iPadPro_129_1, .iPadPro_129_2, .iPadPro_129_3, .iPadPro_129_4, .iPadPro_129_5, .iPadPro_129_6,
                    .iPadAir_13_m2, .iPadAir_13_m3:
                return CGSize(width: 1024, height: 1366)
                
            case .iPadPro_130_m4:
                return CGSize(width: 1032, height: 1376);

            case .iPad:
                let size = UIScreen.main.bounds.size
                return CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
            }
        }
        
        var scale: CGFloat {
            return UIScreen.main.scale
        }
        
        public var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
   }

    //MARK:-
    public enum iPodTouchs: String, WRResolution {
        case iPodTouch = "iPod"
        
        case iPodTouch1 = "iPod touch"
        case iPodTouch2 = "iPod touch (2nd generation)"
        case iPodTouch3 = "iPod touch (3rd generation)"
        case iPodTouch4 = "iPod touch (4rd generation)"
        case iPodTouch5 = "iPod touch (5rd generation)"
        case iPodTouch6 = "iPod touch (6rd generation)"
        case iPodTouch7 = "iPod touch (7rd generation)"
        
        public var size: CGSize {
            switch self {
            case .iPodTouch1, .iPodTouch2, .iPodTouch3, .iPodTouch4:
                return CGSize(width: 320, height: 480)
                
            case .iPodTouch5, .iPodTouch6, .iPodTouch7:
                return CGSize(width: 320, height: 568)
                
            case .iPodTouch:
                let size = UIScreen.main.bounds.size
                return CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
            }
        }
        
        var scale: CGFloat {
            return UIScreen.main.scale
         }
        
        public var resolution: CGSize {
            return CGSize(width: size.width * scale, height: size.height * scale)
        }
    }

    //MARK:-
    public enum AppleWatchs: String {
        case AppleWatch = "Apple Watch"
        
        case AppleWatch_1 = "Apple Watch (1st generation)"

        case AppleWatchSeries_1  = "Apple Watch Series 1"
        case AppleWatchSeries_2  = "Apple Watch Series 2"
        case AppleWatchSeries_3  = "Apple Watch Series 3"
        case AppleWatchSeries_4  = "Apple Watch Series 4"
        case AppleWatchSeries_5  = "Apple Watch Series 5"
        case AppleWatchSeries_6  = "Apple Watch Series 6"
        case AppleWatchSeries_7  = "Apple Watch Series 7"
        case AppleWatchSeries_8  = "Apple Watch Series 8"
        case AppleWatchSeries_9  = "Apple Watch Series 9"
        case AppleWatchSeries_10 = "Apple Watch Series 10"

        case AppleWatchSE = "Apple Watch SE"
        
        case AppleWatchUltra_1 = "Apple Watch Ultra 1"
        case AppleWatchUltra_2 = "Apple Watch Ultra 2"
    }

    //MARK:-
    public enum AppleTVs: String {
        case AppleTV = "Apple TV"
        
        case AppleTV_1 = "Apple TV (1st generation)"
        case AppleTV_2 = "Apple TV (2nd generation)"
        case AppleTV_3 = "Apple TV (3rd generation)"
        
        case AppleTV_HD = "Apple TV HD"

        case AppleTV4K_1 = "Apple TV 4K"
        case AppleTV4K_2 = "Apple TV 4K (2nd generation)"
        case AppleTV4K_3 = "Apple TV 4K (3rd generation)"
    }
}

//MARK: -
/** 设备英寸*/
public enum WRInches: CGFloat {
    case unknown    = 0
    case inches_3_5 = 3.5
    case inches_4_0 = 4.0
    case inches_4_7 = 4.7
    case inches_5_4 = 5.4
    case inches_5_5 = 5.5
    case inches_5_8 = 5.8
    case inches_6_1 = 6.1
    case inches_6_5 = 6.5
    case inches_6_7 = 6.7
    case inches_6_9 = 6.9
}

//MARK: -
/** 设备尺寸*/
public protocol WRDeviceSize {
    var size: CGSize { get }
    var inches: WRInches { get }
}

extension WRDeviceSize {
    public var inches: WRInches {
        let size = size
        let scale = UIScreen.main.scale
        
        if WRDevice.Shared.isPhone {
            switch size.height {
            case 480:
                return .inches_3_5
            case 568:
                return .inches_4_0
            case 667:
                return scale == 3.0 ? .inches_5_5 : .inches_4_7
            case 736:
                return .inches_5_5
            case 812:
                return .inches_5_8
            case 844, 834:
                return .inches_5_4
            case 896:
                return ( scale == 3.0 ? .inches_6_5 : .inches_6_1 )
            case 926:
                return .inches_6_7
            case 956:
                return .inches_6_9
            default:
                return .unknown
            }
        } else if WRDevice.Shared.isPad {
            return .unknown
        }
        
        return .unknown
    }
}

//MARK: -
/** 设备分辨率*/
public protocol WRResolution: WRDeviceSize {
    var resolution: CGSize { get }
}

