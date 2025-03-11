//
//  WRFolder.swift
//  Pods-WRSwiftKit_Example
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public class WRFolder: NSObject {

    /** 缓存地址 */
    @objc public static var CacheUrl : URL?

    /** 缓存文件夹大小 */
    @objc public static var CacheFolderSize : String {
        guard let cacheUrl = self.CacheUrl else {
            return "0 KB"
        }
        let folderSize = self.FolderSize(cacheUrl)
        return ByteCountFormatter.string(fromByteCount: folderSize, countStyle: .file)
    }

    /**删除缓存文件夹*/
    @objc public static func RemoveCacheFolder() throws {
        guard let cacheUrl = self.CacheUrl else {
            return
        }
        try FileManager.default.removeItem(atPath: cacheUrl.absoluteString)
    }

    /**文件夹大小*/
    /// - parameter url: 文件夹地址
    /// - returns: 文件夹大小
    @objc public static func FolderSize(_ url : URL) -> Int64 {
    
        let contents: [URL]
        do {
            contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
        } catch {
            return 0
        }

        var size: Int64 = 0

        for url in contents {
            let isDirectoryResourceValue: URLResourceValues
            do {
                isDirectoryResourceValue = try url.resourceValues(forKeys: [.isDirectoryKey])
            } catch {
                continue
            }

            if isDirectoryResourceValue.isDirectory == true {
                size += WRFolder.FolderSize(url)
            } else {
                let fileSizeResourceValue: URLResourceValues
                do {
                    fileSizeResourceValue = try url.resourceValues(forKeys: [.fileSizeKey])
                } catch {
                    continue
                }

                size += Int64(fileSizeResourceValue.fileSize ?? 0)
            }
        }
        return size
    }
    
    /**删除文件夹*/
    /// - parameter url: 文件夹地址
    @objc public static func RemoveFolder(_ url : URL) throws {
        try FileManager.default.removeItem(atPath: url.absoluteString)
    }
    
    public static func Target(size: Float, range: Int = 2) -> String {
        return "\(String(format: "%1.\(range)f", Btye.value(size: size)))\(Btye.unit(size: size))"
    }
    
    public static func Target(ceil size: Float) -> String {
        let value = Btye.scale(size: size)
        let result: Int = {
            var count = Int(sqrt(value.0 / 8)) - 1
            var result = 8
            while Int(value.0) > result {
                result = Int(pow(2, Float(count)))
                count += 1
            }
            return result
        }()
        
        if result >= 1024 {
            return "\(1)\(Btye(rawValue: Float(value.1 + 1))?.unit ?? Btye.byte.unit)"
        } else {
            return "\(result)\(Btye(rawValue: Float(value.1))?.unit ?? Btye.byte.unit)"
        }
    }
}

//MARK: -
private enum Btye: Float {
    case byte = 1
    case kb = 2
    case mb = 3
    case gb = 4
    case tb = 5
    case pb = 6
    case eb = 7
    case zb = 8
    case yb = 9

    var unit: String {
        switch self {
        case .byte: return "byte"
        case .kb: return "KB"
        case .mb: return "MB"
        case .gb: return "GB"
        case .tb: return "TB"
        case .pb: return "PB"
        case .eb: return "EB"
        case .zb: return "ZB"
        case .yb: return "YB"
        }
    }
    
    static func scale(size: Float) -> (Float, Int) {
        var scale: Float = 1
        var size = size
        while size > 1024 {
            size = size / 1024
            scale += 1
        }
        return (size, Int(scale))
    }
    
    static func unit(size: Float) -> String {
        return Btye(rawValue: Float(scale(size: size).1))?.unit ?? "byte"
    }
    
    static func value(size: Float) -> Float {
        return Btye.scale(size:size).0
    }
}

