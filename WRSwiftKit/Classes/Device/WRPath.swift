//
//  WRPath.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public class WRPath: NSObject {

    @objc public static let Temp     = NSTemporaryDirectory()
    @objc public static let LibCache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    @objc public static let Document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    fileprivate var databasePath = WRPath.Document + "/\(WRDevice.current.appName ?? "db").db"
    
    fileprivate static let Path : WRPath = WRPath()
    
    /** 数据库地址 */
    @objc public static var Database : String {
        get {
            return WRPath.Path.databasePath
        }
        set {
            WRPath.Path.databasePath = newValue
        }
    }

    /**创建文件*/
    /// - parameter folderName: 文件名
    /// - returns: 路径地址
    @objc public static func CreateDirectory(_ folderName : String) -> String {
        let directory = WRPath.Document + "/\(folderName)"
        if !FileManager.default.fileExists(atPath: directory) {
            try? FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
        }
        return directory
    }

}
