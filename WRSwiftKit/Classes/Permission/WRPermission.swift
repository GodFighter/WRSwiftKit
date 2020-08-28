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
public enum WRPermissionStatus: String {
    case notDetermined  = "Not Determined"
    case authorized     = "Authorized"
    case denied         = "Denied"
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
open class WRPermission: NSObject {
    
    public typealias Callback = (WRPermissionStatus) -> Void

    public var type: WRPermissionType

    #if PERMISSION_PHOTOS
    public static let Photos = WRPermissionPhoto(type: .photos)
    #endif
    
    internal init(type: WRPermissionType) {
        self.type = type
    }

    open var status: WRPermissionStatus {
        return .notDetermined
    }
    
    open var infoKey = ""
    
    open func request(_ callback: @escaping Callback) {
        
    }
    

}
