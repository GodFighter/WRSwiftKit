//
//  WRPermissionType.swift
//  Pods
//
//  Created by 项辉 on 2020/8/27.
//

import UIKit

/**权限类型*/
public enum WRPermissionType {

    #if PERMISSION_BLUETOOTH
    /**蓝牙*/
    case bluetooth
    #endif

    #if PERMISSION_CAMERA
    /**相机*/
    case camera
    #endif

    #if PERMISSION_CONTACTS && canImport(Contacts)
    /**通讯录*/
    case contacts
    #endif

    #if PERMISSION_EVENTS
    /**日历*/
    case events
    #endif

    #if PERMISSION_MEDIA_LIBRARY
    /**媒体库*/
    @available(iOS 9.3, *) case mediaLibrary
    #endif

    #if PERMISSION_MICROPHONE
     /**麦克风*/
    case microphone
    #endif

    #if PERMISSION_NOTIFICATIONS
    /**通知*/
    @available(iOS 10.0, *)
    case notifications(UNAuthorizationOptions)
    #endif

    #if PERMISSION_PHOTOS
    /**相册*/
    case photos
    #endif

    #if PERMISSION_SPEECH_RECOGNIZER && canImport(Speech)
    /**语音录制*/
    case speechRecognizer
    #endif


    #if PERMISSION_LOCATION
    case locationAlways
    case locationWhenInUse
    #endif


    #if PERMISSION_REMINDERS
    case reminders
    #endif

    #if PERMISSION_MOTION
    case motion
    #endif

    #if PERMISSION_SIRI && canImport(Intents)
    case siri
    #endif

    case never
}

extension WRPermissionType: CustomStringConvertible {
    public var description: String {
        switch self {
        #if PERMISSION_BLUETOOTH
        case .bluetooth: return "Bluetooth"
        #endif

        #if PERMISSION_CAMERA
        case .camera: return "Camera"
        #endif

        #if PERMISSION_CONTACTS
        case .contacts: return "Contacts"
        #endif

        #if PERMISSION_EVENTS
        case .events: return "Events"
        #endif

        #if PERMISSION_MEDIA_LIBRARY
        case .mediaLibrary: return "Media Library"
        #endif

        #if PERMISSION_LOCATION
        case .locationAlways: return "Location"
        case .locationWhenInUse: return "Location"
        #endif

        #if PERMISSION_NOTIFICATIONS
        case .notifications: return "Notifications"
        #endif

        #if PERMISSION_MICROPHONE
        case .microphone: return "Microphone"
        #endif

        #if PERMISSION_REMINDERS
        case .reminders: return "Reminders"
        #endif

        #if PERMISSION_MOTION
        case .motion: return "Motion"
        #endif

        #if PERMISSION_SPEECH_RECOGNIZER && canImport(Speech)
        case .speechRecognizer: return "Speech Recognizer"
        #endif

        #if PERMISSION_SIRI && canImport(Intents)
        case .siri: return "SiriKit"
        #endif

        #if PERMISSION_PHOTOS
        case .photos: return "Photos"
        #endif

        case .never: fatalError()
        }
    }
}
