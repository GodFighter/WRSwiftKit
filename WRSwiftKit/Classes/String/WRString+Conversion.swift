//
//  String+Conversion.swift
//  Pods
//
//  Created by 项辉 on 2020/9/22.
//

import UIKit

public protocol WRStringConversion { }

fileprivate extension WRStringConversion {
    var _conversion: String {
        if self is String || self is NSString {
            return self as! String
        } else if let `self` = self as? WRStringExtension{
            return self.value
        }
        return ""
    }
}

fileprivate typealias WRStringConversion_Public = WRStringConversion
public extension WRStringConversion_Public {
    /// 布尔值
    ///
    ///     let value = "1"
    ///     // Prints: true
    ///
    var toBool: Bool {
        let selfLowercased = _conversion.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        default:
            return false
        }
    }
    
    /// 整形值
    var toInt: Int? {
        return Int(_conversion)
    }
    
    /// 32位浮点值
    var toFloat: Float? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion)?.floatValue
    }

    /// 64位浮点值
    var toDouble: Double? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion)?.doubleValue
    }

    /// CGFloat浮点值
    var ToCGFloat: CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion) as? CGFloat
    }

    /// URL
    var toUrl: URL? {
        return URL(string: _conversion)
    }
    
    /// 解码URL
    ///
    ///     let http = "https%3A%2F%2Fwww.baidu.com"
    ///     // Prints: https://www.baidu.com
    ///
    var urlDecoded: String {
        return _conversion.removingPercentEncoding ?? _conversion
    }

    /// 编码URL
    ///
    ///     let http = "https://www.baidu.com"
    ///     // Prints: https%3A%2F%2Fwww.baidu.com
    ///
    var urlEncoded: String {
        return _conversion.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// String转Date
    ///
    ///     let date = "2020-02-02"
    ///     // Prints: Optional(2020-02-01 16:00:00 +0000)
    ///
    var toDate: Date? {
        let selfLowercased = _conversion.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// Date String转Date
    ///
    ///     let date = "2020:02:02 12:00"
    ///     date.wr.date(withFormat: "yyyy:MM:dd HH:mm")
    ///     // Prints: Optional(2020-02-02 04:00:00 +0000)
    /// - parameter format: 时间格式
    /// - returns: Date
    ///
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: _conversion)
    }

    /// html
    var toHtml: String? {
        guard let data = _conversion.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string
    }

    /// 剥离xml
    var stripXml: String {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escaped = _conversion.replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped
    }

    /// 剥离html
    var stripHtml: String {
        return _conversion.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }

    /// 剥离空格和回车
    var stripSpacesAndNewLines: String {
        return _conversion.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

    /// 剥离空格
    var stripSpaces: String {
        return _conversion.replacingOccurrences(of: " ", with: "")
    }

    /// 剥离回车
    var stripNewLines: String {
        return _conversion.replacingOccurrences(of: "\n", with: "")
    }

    /// base64解码
    var base64Decoded: String? {
        let remainder = _conversion.count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: _conversion + padding, options: .ignoreUnknownCharacters) else { return nil }

        return String(data: data, encoding: .utf8)
    }

    /// base64编码
    var base64Encoded: String? {
        let plainData = _conversion.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// 将普通字符串转16进制字符串
    ///
    ///     "t".wr.toHexString
    ///     // Prints: 0x74
    ///
    var toHexString: String {
        let data = Data(_conversion.utf8)
        return data.map{ String(format: "0x%X", $0) }.joined()
    }

    /// 将普通字符串转短16进制字符串
    ///
    ///     "t".wr.toShortHexString
    ///     // Prints: 74
    ///
    var toShortHexString: String {
        let data = Data(_conversion.utf8)
        return data.map{ String(format: "%X", $0) }.joined()
    }

    /// 将普通字符串转unicode字符串
    ///
    ///     "tat".wr.toUnicodeString
    ///     // Prints: 74 61 74
    ///
    var toUnicodeString: String {
        return _conversion.unicodeScalars.map { String(format: "%X", $0.value) }.joined(separator: " ")
    }
    ///unicode字符串数组
    ///
    ///     "tt".wr.unicodeStrings
    ///     // Prints: ["74", "74"]
    ///
    var unicodeStrings: [String] {
        return _conversion.unicodeScalars.map { "\(String(format: "%X", $0.value))" }
    }
    
    ///unicode字符串数组
    ///
    ///     "tt".wr.unicodes
    ///     // Prints: [74, 74]
    ///
    var unnicodes: [Int] {
        return _conversion.unicodeScalars.map { Int($0.value) }
    }

    /// 16进制字符串转10进制整型
    ///
    ///     "000073".wr.hexValue
    ///     // Prints 115
    ///
    var hexStringToInt: UInt32 {
        return UInt32(_conversion.lowercased().hasPrefix("0x") ? _conversion.dropFirst(2) : _conversion[...], radix: 16) ?? 0
    }

    /// 转16进制Data
    var hexData: Data? {
        var data = Data(capacity: _conversion.count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: _conversion, range: NSRange(_conversion.startIndex..., in: _conversion)) { match, _, _ in
            let byteString = (_conversion as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }

        guard data.count > 0 else { return nil }

        return data
    }
    
    /// 根据16进制字符串创建字符串
    ///
    ///     WRString(hex: "0079", encoding: .utf16BigEndian)
    ///     // Prints: Optional("y")
    /// - parameter hexString: 16进制字符串
    /// - parameter encoding: 编码方式
    /// - returns: 字符串
    ///
    static func WRString(hex hexString: String, encoding: String.Encoding = .utf8) -> String? {
        guard let data = hexString.wr.hexData else {
            return nil
        }
        return String.init(data: data, encoding: encoding)
    }

}
