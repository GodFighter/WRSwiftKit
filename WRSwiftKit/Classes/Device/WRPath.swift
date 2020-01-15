//
//  WRPath.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public class WRPath: NSObject {

    @objc public static let temp     = NSTemporaryDirectory()
    @objc public static let libCache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    @objc public static let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    fileprivate var databasePath = WRPath.document + "/\(WRDevice.Info.appName).db"
    
    fileprivate static let path : WRPath = WRPath()
    
    /** 数据库地址 */
    @objc public static var database : String {
        get {
            return WRPath.path.databasePath
        }
        set {
            WRPath.path.databasePath = newValue
        }
    }

    /**创建文件*/
    /// - parameter folderName: 文件名
    /// - returns: 路径地址
    @objc public static func createDirectory(_ folderName : String) -> String {
        let directory = WRPath.document + "/\(folderName)"
        if !FileManager.default.fileExists(atPath: directory) {
            try? FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
        }
        return directory
    }

}
