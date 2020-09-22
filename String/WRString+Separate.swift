//
//  WRString+Separate.swift
//  Pods
//
//  Created by 项辉 on 2020/9/22.
//

import UIKit

public protocol WRStringSeparate { }

fileprivate extension WRStringSeparate {
    var _separate: String {
        if self is String || self is NSString {
            return self as! String
        } else if let `self` = self as? WRStringExtension{
            return self.value
        }
        return ""
    }
}

fileprivate typealias WRStringSeparate_Public = WRStringSeparate
public extension WRStringSeparate_Public {

    /// 分割成不同的单词
    ///
    ///     "hello word".wr.words
    ///     // Prints ["asdsds", "dfsdf"]
    ///
    var words: [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = _separate.components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }

    /// 使字符串分割
    ///
    ///
    /// 使用指定字符分割原始字符串
    ///
    ///     "abcd".wr.separate(every: 1, with: "*")
    ///     // Prints "a*b*c*d"
    ///  - parameter every: 间隔
    ///  - parameter separator: 分割字符串
    /// - returns: 分割后字符串
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(_separate).count, by: every).map {
            Array(Array(_separate)[$0..<min($0 + every, Array(_separate).count)])
        }.joined(separator: separator))
    }

}
