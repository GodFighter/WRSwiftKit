//
//  WRNotification.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public protocol WRNotifyProtocol {
    
    @objc var key : String { get }
    @objc var rawValue : String { get }
    
    @objc var name : Notification.Name    { get }
    @objc var failed : Notification.Name  { get }
    @objc var success : Notification.Name { get }
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
