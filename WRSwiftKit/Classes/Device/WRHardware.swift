//
//  WRDeviceType.swift
//  WRSwiftKit
//
//  Created by 项辉 on 2021/4/17.
//

import Foundation

//MARK: -
internal enum WRHardware {
    
    case unknown
    case iPhone(_ iPhone: iPhoneKind)
    case iPad(_ iPad: iPadKind)
    case iPodTouch(_ iPodTouch: iPodTouchKind)
    case AppleWatch(_ AppleWatch: AppleWatchKind)
    case AppleTV(_ AppleTV: AppleTVKind)
    
    init(_ identifier: String) {
        switch identifier {
        /**iPhone*/
        case "iPhone1,1":                           self = .iPhone(.iPhone2G)
            
        case "iPhone1,2":                           self = .iPhone(.iPhone3G)
        case "iPhone2,1":                           self = .iPhone(.iPhone3GS)
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": self = .iPhone(.iPhone4)
        case "iPhone4,1":                           self = .iPhone(.iPhone4S)
            
        case "iPhone5,1", "iPhone5,2":              self = .iPhone(.iPhone5)
        case "iPhone5,3", "iPhone5,4":              self = .iPhone(.iPhone5c)
        case "iPhone6,1", "iPhone6,2":              self = .iPhone(.iPhone5s)
            
        case "iPhone7,2":                           self = .iPhone(.iPhone6)
        case "iPhone7,1":                           self = .iPhone(.iPhone6Plus)
        case "iPhone8,1":                           self = .iPhone(.iPhone6s)
        case "iPhone8,2":                           self = .iPhone(.iPhone6sPlus)
            
        case "iPhone8,4":                           self = .iPhone(.iPhoneSE1)
        case "iPhone12,8":                          self = .iPhone(.iPhoneSE2)
        case "iPhone14,6":                          self = .iPhone(.iPhoneSE3)

        case "iPhone9,1", "iPhone9,3":              self = .iPhone(.iPhone7)
        case "iPhone9,2", "iPhone9,4":              self = .iPhone(.iPhone7Plus)
            
        case "iPhone10,1", "iPhone10,4":            self = .iPhone(.iPhone8)
        case "iPhone10,2", "iPhone10,5":            self = .iPhone(.iPhone8Plus)
            
        case "iPhone10,3", "iPhone10,6":            self = .iPhone(.iPhoneX)
        case "iPhone11,8":                          self = .iPhone(.iPhoneXR)
        case "iPhone11,2":                          self = .iPhone(.iPhoneXS)
        case "iPhone11,6", "iPhone11,4":            self = .iPhone(.iPhoneXSMax)
            
        case "iPhone12,1":                          self = .iPhone(.iPhone11)
        case "iPhone12,3":                          self = .iPhone(.iPhone11Pro)
        case "iPhone12,5":                          self = .iPhone(.iPhone11ProMax)
            
        case "iPhone13,1":                          self = .iPhone(.iPhone12Mini)
        case "iPhone13,2":                          self = .iPhone(.iPhone12)
        case "iPhone13,3":                          self = .iPhone(.iPhone12Pro)
        case "iPhone13,4":                          self = .iPhone(.iPhone12ProMax)

        case "iPhone14,2":                          self = .iPhone(.iPhone13Pro)
        case "iPhone14,3":                          self = .iPhone(.iPhone13ProMax)
        case "iPhone14,4":                          self = .iPhone(.iPhone13Mini)
        case "iPhone14,5":                          self = .iPhone(.iPhone13)
            
        case "iPhone14,7":                          self = .iPhone(.iPhone14)
        case "iPhone14,8":                          self = .iPhone(.iPhone14Plus)
        case "iPhone15,2":                          self = .iPhone(.iPhone14Pro)
        case "iPhone15,3":                          self = .iPhone(.iPhone14ProMax)

        case "iPhone15,4":                          self = .iPhone(.iPhone15)
        case "iPhone15,5":                          self = .iPhone(.iPhone15Plus)
        case "iPhone16,1":                          self = .iPhone(.iPhone15Pro)
        case "iPhone16,2":                          self = .iPhone(.iPhone15ProMax)

        case "iPhone17,3":                          self = .iPhone(.iPhone16)
        case "iPhone17,4":                          self = .iPhone(.iPhone16Plus)
        case "iPhone17,1":                          self = .iPhone(.iPhone16Pro)
        case "iPhone17,2":                          self = .iPhone(.iPhone16ProMax)
        case "iPhone17,5":                          self = .iPhone(.iPhone16e)

        case "iPhone18,3":                          self = .iPhone(.iPhone17)
        case "iPhone18,1":                          self = .iPhone(.iPhone17Pro)
        case "iPhone18,2":                          self = .iPhone(.iPhone17ProMax)
        case "iPhone18,4":                          self = .iPhone(.iPhoneAir)

            /**iPad*/
        case "iPad1,1":                                   self = .iPad(.iPad1)
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  self = .iPad(.iPad2)
        case "iPad3,1", "iPad3,2", "iPad3,3":             self = .iPad(.iPad3)
        case "iPad3,4", "iPad3,5", "iPad3,6":             self = .iPad(.iPad4)
        case "iPad6,11", "iPad6,12":                      self = .iPad(.iPad5)
        case "iPad7,5", "iPad7,6":                        self = .iPad(.iPad6)
        case "iPad7,11", "iPad7,12":                      self = .iPad(.iPad7)
        case "iPad11,6", "iPad11,7":                      self = .iPad(.iPad8)
        case "iPad12,1", "iPad12,2":                      self = .iPad(.iPad9)
        case "iPad13,18", "iPad13,19":                    self = .iPad(.iPad10)
        case "iPad15,7", "iPad15,8":                      self = .iPad(.iPad_a16)

        case "iPad2,5", "iPad2,6", "iPad2,7":   self = .iPad(.iPadMini_1)
        case "iPad4,4", "iPad4,5", "iPad4,6":   self = .iPad(.iPadMini_2)
        case "iPad4,7", "iPad4,8", "iPad4,9":   self = .iPad(.iPadMini_3)
        case "iPad5,1", "iPad5,2":              self = .iPad(.iPadMini_4)
        case "iPad11,1", "iPad11,2":            self = .iPad(.iPadMini_5)
        case "iPad14,1", "iPad14,2":            self = .iPad(.iPadMini_6)
        case "iPad16,1", "iPad16,2":            self = .iPad(.iPadMini_a17_pro)

        case "iPad4,1", "iPad4,2", "iPad4,3":   self = .iPad(.iPadAir_1)
        case "iPad5,3", "iPad5,4":              self = .iPad(.iPadAir_2)
        case "iPad11,3", "iPad11,4":            self = .iPad(.iPadAir_3)
        case "iPad13,1", "iPad13,2":            self = .iPad(.iPadAir_4)
        case "iPad13,16", "iPad13,17":          self = .iPad(.iPadAir_5)
        case "iPad14,8", "iPad14,9":            self = .iPad(.iPadAir_11_m2)
        case "iPad14,10", "iPad14,11":          self = .iPad(.iPadAir_13_m2)
        case "iPad15,3", "iPad15,4":            self = .iPad(.iPadAir_11_m3)
        case "iPad15,5", "iPad15,6":            self = .iPad(.iPadAir_13_m3)

        case "iPad6,3", "iPad6,4":                              self = .iPad(.iPadPro_097_1)
        case "iPad6,7", "iPad6,8":                              self = .iPad(.iPadPro_129_1)
        case "iPad7,1", "iPad7,2":                              self = .iPad(.iPadPro_129_2)
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":        self = .iPad(.iPadPro_129_3)
        case "iPad8,11", "iPad8,12":                            self = .iPad(.iPadPro_129_4)
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":  self = .iPad(.iPadPro_129_5)
        case "iPad7,3", "iPad7,4":                              self = .iPad(.iPadPro_105_1)
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":        self = .iPad(.iPadPro_110_1)
        case "iPad8,9", "iPad8,10":                             self = .iPad(.iPadPro_110_2)
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":    self = .iPad(.iPadPro_110_3)
//        case "unknown":    self = .iPad(.iPadPro_110_4)
//        case "unknown":    self = .iPad(.iPadPro_129_6)
        case "iPad16,3", "iPad16,4":                            self = .iPad(.iPadPro_110_m4)
        case "iPad16,5", "iPad16,6":                            self = .iPad(.iPadPro_130_m4)

        /**iPod Touch*/
        case "iPod1,1": self = .iPodTouch(.iPodTouch1)
        case "iPod2,1": self = .iPodTouch(.iPodTouch2)
        case "iPod3,1": self = .iPodTouch(.iPodTouch3)
        case "iPod4,1": self = .iPodTouch(.iPodTouch4)
        case "iPod5,1": self = .iPodTouch(.iPodTouch5)
        case "iPod7,1": self = .iPodTouch(.iPodTouch6)
        case "iPod9,1": self = .iPodTouch(.iPodTouch7)
            
        /**Apple Watch*/
        case "Watch1,1", "Watch1,2":                            self = .AppleWatch(.AppleWatch_1)
        case "Watch2,6", "Watch2,7":                            self = .AppleWatch(.AppleWatchSeries_1)
        case "Watch2,3", "Watch2,4":                            self = .AppleWatch(.AppleWatchSeries_2)
        case "Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4":    self = .AppleWatch(.AppleWatchSeries_3)
        case "Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4":    self = .AppleWatch(.AppleWatchSeries_4)
        case "Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4":    self = .AppleWatch(.AppleWatchSeries_5)
        case "Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4":    self = .AppleWatch(.AppleWatchSeries_6)
        case "Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12": self = .AppleWatch(.AppleWatchSE)
        case "Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9":    self = .AppleWatch(.AppleWatchSeries_7)
        case "Watch6,10", "Watch6,11", "Watch6,12", "Watch6,13": self = .AppleWatch(.AppleWatchSE)
        case "Watch6,16", "Watch6,17":                          self = .AppleWatch(.AppleWatchSeries_8)
        case "Watch6,18":                                       self = .AppleWatch(.AppleWatchUltra_1)
        case "Watch7,1", "Watch7,2", "Watch7,3", "Watch7,4":    self = .AppleWatch(.AppleWatchSeries_9)
        case "Watch7,5":                                        self = .AppleWatch(.AppleWatchUltra_2)
        case "Watch7,8", "Watch7,9", "Watch7,10", "Watch7,11":  self = .AppleWatch(.AppleWatchSeries_10)

        /**Apple TV*/
        case "AppleTV1,1":                  self = .AppleTV(.AppleTV_1)
        case "AppleTV2,1":                  self = .AppleTV(.AppleTV_2)
        case "AppleTV3,1", "AppleTV3,2":    self = .AppleTV(.AppleTV_3)
        case "AppleTV5,3":                  self = .AppleTV(.AppleTV_HD)
        case "AppleTV6,2":                  self = .AppleTV(.AppleTV4K_1)
        case "AppleTV11,1":                 self = .AppleTV(.AppleTV4K_2)
        case "AppleTV14,1":                 self = .AppleTV(.AppleTV4K_3)

        default: self = .unknown
        }
    }
    
    var name: String {
        switch self {
        case .unknown:
            return "unknown"
        case .iPhone(let iPhone):
            return iPhone.rawValue
        case .iPad(let iPad):
            return iPad.rawValue
        case .iPodTouch(let iPodTouch):
            return iPodTouch.rawValue
        case .AppleWatch(let appleWatch):
            return appleWatch.rawValue
        case .AppleTV(let appleTV):
            return appleTV.rawValue
        }
    }
    
    var size: CGSize {
        switch self {
        case .iPhone(let iPhone):       return iPhone.size
        case .iPad(let iPad):           return iPad.size
        case .iPodTouch(let iPodTouch): return iPodTouch.size
        default:                        return .zero
        }
    }
    
    var inches: CGFloat {
        switch self {
        case .iPhone(let iPhone):       return iPhone.inches
        case .iPad(let iPad):           return iPad.inches
        case .iPodTouch(let iPodTouch): return iPodTouch.inches
        default:                        return 0
        }
    }
    
    var resolution: CGSize {
        switch self {
        case .iPhone(let iPhone):       return iPhone.resolution
        case .iPad(let iPad):           return iPad.resolution
        case .iPodTouch(let iPodTouch): return iPodTouch.resolution
        default:                        return .zero
        }
    }
    
    fileprivate static var scale: CGFloat {
        return UIScreen.main.scale
    }
    
    var systemName: String? {
        switch self {
        case .unknown:
            return nil
        case .iPhone(_):
            return UIDevice.current.systemName
        case .iPad(_):
            if #available(iOS 13, *), UIDevice.current.systemName == "iOS" {
              return "iPadOS"
            } else {
              return UIDevice.current.systemName
            }
        case .iPodTouch(_):
            return "iOS"
        case .AppleWatch(_):
            return "watchOS"
        case .AppleTV(_):
            return "tvOS"
        }
    }
}

//MARK: -
enum iPhoneKind: String, WRDeviceSize {
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
    case iPhone7Plus = "iPhone 7 Plus"
    
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
    
    case iPhone17       = "iPhone 17"
    case iPhone17Pro    = "iPhone 17 Pro"
    case iPhone17ProMax = "iPhone 17 Pro Max"
    case iPhoneAir      = "iPhone Air"

    var size: CGSize {
        switch self {
        case .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4, .iPhone4S:
            return CGSize(width: 320, height: 480)
            
        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE1:
            return CGSize(width: 320, height: 568)
            
        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneSE3:
            return CGSize(width: 375, height: 667)
            
        case .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone13Mini:
            return CGSize(width: 375, height: 812)
            
        case .iPhone12Mini:
            return CGSize(width: 360, height: 780)

        case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro, .iPhone14:
            return CGSize(width: 390, height: 844)
            
        case .iPhone14Pro, .iPhone15, .iPhone15Pro, .iPhone16, .iPhone16e:
            return CGSize(width: 393, height: 852)

        case .iPhone16Pro, .iPhone17, .iPhone17Pro:
            return CGSize(width: 402, height: 874)

        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
            return CGSize(width: 414, height:736)
            
        case .iPhone11, .iPhoneXR, .iPhone11ProMax, .iPhoneXSMax:
            return CGSize(width: 414, height: 896)
                        
        case .iPhoneAir:
            return CGSize(width: 420, height: 912)

        case .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus:
            return CGSize(width: 428, height: 926)
            
        case .iPhone14ProMax, .iPhone15Plus, .iPhone15ProMax, .iPhone16Plus:
            return CGSize(width: 430, height: 832)

        case .iPhone16ProMax, .iPhone17ProMax:
            return CGSize(width: 440, height: 956)
       
        case .iPhone:
            let size = UIScreen.main.bounds.size
            return CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
        }
    }
    
    var inches: CGFloat {
        switch self {
        case .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4, .iPhone4S:
            return 3.5
            
        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE1:
            return 4.0

        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneSE3:
            return 4.7
            
        case .iPhone12Mini, .iPhone13Mini:
            return 5.4

        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
            return 5.5

        case .iPhoneX, .iPhoneXS, .iPhone11Pro:
            return 5.8

        case .iPhone11, .iPhoneXR, .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro, .iPhone14, .iPhone14Pro, .iPhone15, .iPhone15Pro, .iPhone16, .iPhone16e:
            return 6.1
            
        case .iPhone16Pro:
            return 6.3

        case .iPhoneXSMax, .iPhone11ProMax, .iPhone17, .iPhone17Pro:
            return 6.5
           
        case .iPhone16Plus, .iPhoneAir:
            return 6.5

        case .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus, .iPhone14ProMax, .iPhone15ProMax, .iPhone15Plus, .iPhone16ProMax, .iPhone17ProMax:
            return 6.9
            
        case .iPhone:
            return 0
        }
    }
}

//MARK: -
enum iPadKind: String, WRDeviceSize {
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

    var size: CGSize {
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
    
    var inches: CGFloat {
        switch self {
        case .iPadMini_1, .iPadMini_2, .iPadMini_3, .iPadMini_4, .iPadMini_5:
            return 7.9

        case .iPadMini_6,
                .iPadMini_a17_pro:
            return 8.3

        case .iPad1, .iPad2, .iPad3, .iPad4, .iPad5, .iPad6,
                .iPadAir_1, .iPadAir_2,
                .iPadPro_097_1:
            return 9.7

        case .iPad7, .iPad8, .iPad9:
            return 10.2
            
        case .iPadAir_3,
                .iPadPro_105_1:
            return 10.5

        case .iPad10,
                .iPadAir_4, .iPadAir_5:
            return 10.9
            
        case .iPad_a16,
                .iPadAir_11_m2, .iPadAir_11_m3,
                .iPadPro_110_1, .iPadPro_110_2, .iPadPro_110_3, .iPadPro_110_4, .iPadPro_110_m4:
            return 11.0
            
        case .iPadPro_129_1, .iPadPro_129_2, .iPadPro_129_3, .iPadPro_129_4, .iPadPro_129_5, .iPadPro_129_6:
            return 12.9

        case .iPadAir_13_m2, .iPadAir_13_m3,
                .iPadPro_130_m4:
            return 13.0
                            
        case .iPad:
            return 0
        }
    }

}

//MARK: -
enum iPodTouchKind: String, WRDeviceSize {
    case iPodTouch = "iPod"
    
    case iPodTouch1 = "iPod touch"
    case iPodTouch2 = "iPod touch (2nd generation)"
    case iPodTouch3 = "iPod touch (3rd generation)"
    case iPodTouch4 = "iPod touch (4rd generation)"
    case iPodTouch5 = "iPod touch (5rd generation)"
    case iPodTouch6 = "iPod touch (6rd generation)"
    case iPodTouch7 = "iPod touch (7rd generation)"
    
    var size: CGSize {
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
    
    var inches: CGFloat {
        switch self {
        case .iPodTouch1, .iPodTouch2, .iPodTouch3, .iPodTouch4:
            return 3.5
            
        case .iPodTouch5, .iPodTouch6, .iPodTouch7:
            return 4.0
            
        case .iPodTouch:
            return 0
        }
    }
}

//MARK: -
enum AppleWatchKind: String {
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

//MARK: -
enum AppleTVKind: String {
    case AppleTV = "Apple TV"
    
    case AppleTV_1 = "Apple TV (1st generation)"
    case AppleTV_2 = "Apple TV (2nd generation)"
    case AppleTV_3 = "Apple TV (3rd generation)"
    
    case AppleTV_HD = "Apple TV HD"

    case AppleTV4K_1 = "Apple TV 4K"
    case AppleTV4K_2 = "Apple TV 4K (2nd generation)"
    case AppleTV4K_3 = "Apple TV 4K (3rd generation)"
}

//MARK: -
/** 设备尺寸*/
protocol WRDeviceSize {
    var size: CGSize { get } //尺寸
    var inches: CGFloat { get } //英寸
    var resolution: CGSize { get } //设备分辨率
}

extension WRDeviceSize {
    var resolution: CGSize {
        return CGSize(width: size.width * WRHardware.scale, height: size.height * WRHardware.scale)
    }
}
