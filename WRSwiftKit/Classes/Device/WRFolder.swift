//
//  WRFolder.swift
//  Pods-WRSwiftKit_Example
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public class WRFolder: NSObject {

    /** 缓存地址 */
    @objc public static var cacheUrl : URL?

    /** 缓存文件夹大小 */
    @objc public static var cacheFolderSize : String {
        guard let cacheUrl = self.cacheUrl else {
            return "0 KB"
        }
        let folderSize = self.folderSize(cacheUrl)
        return ByteCountFormatter.string(fromByteCount: folderSize, countStyle: .file)
    }

    /**删除缓存文件夹*/
    @objc public static func removeCacheFolder() {
        guard let cacheUrl = self.cacheUrl else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: cacheUrl.absoluteString)
        } catch {
            debugPrint("\(error)")
        }
    }

    /**文件夹大小*/
    /// - parameter url: 文件夹地址
    /// - returns: 文件夹大小
    @objc public static func folderSize(_ url : URL) -> Int64 {
    
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
                size += WRFolder.folderSize(url)
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
    @objc public static func removeFolder(_ url : URL) {
        do {
            try FileManager.default.removeItem(atPath: url.absoluteString)
        } catch {
            debugPrint("\(error)")
        }
    }

}
