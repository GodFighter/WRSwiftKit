//
//  WRPermission.swift
//  Pods
//
//  Created by 项辉 on 2020/8/27.
//

import UIKit


//public protocol WRPermissionProtocol {
//    typealias Callback = (WRPermissionStatus) -> Void
//    var status1: WRPermissionStatus { get }
//    func request(_ callback: @escaping Callback)
//}

// MARK:- WRPermissionStatus
/**权限状态*/
public enum WRPermissionStatus: String {
    /**未请求*/
    case notDetermined  = "Not Determined"
    /**已授权*/
    case authorized     = "Authorized"
    /**已拒绝*/
    case denied         = "Denied"
    /**不可用*/
    case disabled       = "Disabled"
    
    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(rawValue: string)
    }
}

extension WRPermissionStatus: CustomStringConvertible {
    /// The textual representation of self.
    public var description: String {
        return rawValue
    }
}

// MARK:- WRPermission
/**权限*/
open class WRPermission: NSObject {
    
    /**回调方法*/
    public typealias Callback = (WRPermissionStatus) -> Void
    internal var callback: Callback?

    /**权限类型*/
    public var type: WRPermissionType

    #if PERMISSION_BLUETOOTH
    /**蓝牙权限实例*/
    public static let Bluetooth = WRPermissionBluetooth(type: .bluetooth)
    #endif

    #if PERMISSION_CAMERA
    /**相机权限实例*/
    public static let Camera = WRPermissionCamera(type: .camera)
    #endif

    #if PERMISSION_CONTACTS && canImport(Contacts)
    /** 通讯录权限实例 */
    public static let Contacts = WRPermissionContacts(type: .contacts)
    #endif

    #if PERMISSION_EVENTS
    /** 日历权限实例 */
    public static let Events = WRPermissionEvents(type: .events)
    #endif

    #if PERMISSION_LOCATION
    /** 位置权限实例 */
    /**
     始终
    */
    public static let LocationAlways = WRPermissionLocationAlways(type: .locationAlways)
    /**
     使用时
    */
    public static let LocationWhenInUse = WRPermissionLocationWhenInUse(type: .locationWhenInUse)
    #endif

    #if PERMISSION_MEDIA_LIBRARY
    /** 媒体库权限实例 */
    @available(iOS 9.3, *)
    public static let MediaLibrary = WRPermissionMediaLibrary(type: .mediaLibrary)
    #endif

    #if PERMISSION_MICROPHONE
    /**麦克风权限实例*/
    public static let Microphone = WRPermissionMicrophone(type: .microphone)
    #endif
    
    #if PERMISSION_MOTION
    /**移动数据权限*/
    public static let Motion = WRPermissionMotion(type: .motion)
    #endif

    #if PERMISSION_NOTIFICATIONS
    /** 通知权限实例 */
    @available(iOS 10.0, *)
    public static let Notifications: WRPermissionNotifications = {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        return WRPermissionNotifications(type: .notifications(options))
    }()
    
    private static var _Notifications: WRPermissionNotifications?
    /** 通知权限方法 */
    @available(iOS 10.0, *)
    public static func Notifications(options: UNAuthorizationOptions) -> WRPermissionNotifications {
        let permission = WRPermissionNotifications(type: .notifications(options))
        _Notifications = permission
        return permission
    }
    #endif

    #if PERMISSION_PHOTOS
    /**图片权限实例*/
    public static let Photos = WRPermissionPhoto(type: .photos)
    #endif
    
    #if PERMISSION_REMINDERS
    /**记事本权限实例*/
    public static let Reminders = WRPermissionReminders(type: .reminders)
    #endif

    #if PERMISSION_SIRI && canImport(Intents)
    public static let Siri = WRPermissionSiri(type: .siri)
    #endif

    #if PERMISSION_SPEECH_RECOGNIZER && canImport(Speech)
    /** 语音录制权限实例 */
    public static let SpeechRecognizer = WRPermissionSpeech(type: .speechRecognizer)
    #endif

    
    internal init(type: WRPermissionType) {
        self.type = type
    }

    /**权限状态*/
    open var status: WRPermissionStatus {
        return .notDetermined
    }
    
    /**info.plist需要key*/
    open var infoKey: String {
        return ""
    }
    
    /**权限请求方法*/
    /// - parameter callback: 请求回调block
    open func request(_ callback: @escaping Callback) {
        
    }
    

}
