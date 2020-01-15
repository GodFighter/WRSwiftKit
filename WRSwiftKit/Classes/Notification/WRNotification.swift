//
//  WRNotification.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

/** 通知key协议 */
public protocol WRNotifyProtocol {
    
    var key : String { get }
    var rawValue : String { get }
    
    var name : Notification.Name    { get }
    var failed : Notification.Name  { get }
    var success : Notification.Name { get }
}

public extension WRNotifyProtocol{
   
    var name : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)")
    }
    
    var failed : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)_Failed")
    }
    
    var success : Notification.Name {
        return Notification.Name("\(self.key)_Notify_\(self.rawValue)_Success")
    }
}
