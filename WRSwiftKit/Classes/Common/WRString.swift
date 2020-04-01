//
//  WRString.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

//MARK:-  Judge
public protocol WRStringJudge {

}

public extension WRStringJudge {
    fileprivate var _judge: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
}

fileprivate typealias WRStringJudge_Public = WRStringJudge
public extension WRStringJudge_Public {
    var isIP : Bool {
        return validate(_judge, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    
    var isUrl : Bool {
        return validate(_judge, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }

    var isEmail : Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"

        return validate(_judge, pattern: regex)
    }

    var isPhoneNumber : Bool {
        return validate(_judge, pattern: "^(1)\\d{10}$")
    }

    var isCar: Bool {
        return validate(_judge, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
}


//MARK:-  Conversion
public protocol WRStringConversion {
}

fileprivate extension WRStringConversion {
    var _conversion: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
}

fileprivate typealias WRStringConversion_Public = WRStringConversion
public extension WRStringConversion_Public {
    var bool: Bool? {
        let selfLowercased = _conversion.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    var int: Int? {
        return Int(_conversion)
    }
    
    var float: Float? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion)?.floatValue
    }

    var double: Double? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion)?.doubleValue
    }

    var cgFloat: CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        return formatter.number(from: _conversion) as? CGFloat
    }

    var url: URL? {
        return URL(string: _conversion)
    }
    
    var urlDecoded: String {
        return _conversion.removingPercentEncoding ?? _conversion
    }

    var urlEncoded: String {
        return _conversion.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var date: Date? {
        let selfLowercased = _conversion.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: _conversion)
    }

    var dateTime: Date? {
        let selfLowercased = _conversion.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }

    var html: String? {
        guard let data = _conversion.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string
    }

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

    var stripHtml: String {
        return _conversion.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }

    var stripSpacesAndNewLines: String {
        return _conversion.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

    var stripSpaces: String {
        return _conversion.replacingOccurrences(of: " ", with: "")
    }

    var stripNewLines: String {
        return _conversion.replacingOccurrences(of: "\n", with: "")
    }

    var base64Decoded: String? {
        let remainder = _conversion.count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: _conversion + padding, options: .ignoreUnknownCharacters) else { return nil }

        return String(data: data, encoding: .utf8)
    }

    var base64Encoded: String? {
        let plainData = _conversion.data(using: .utf8)
        return plainData?.base64EncodedString()
    }

}


//MARK:-  Size
public protocol WRStringSize {
}

fileprivate extension WRStringSize {
    var _size: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
}

fileprivate typealias WRStringSize_Public = WRStringSize
public extension WRStringSize_Public {
    func width(_ font : UIFont) -> CGFloat {
        return _size.boundingRect(with: CGSize(), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).width
    }

    func height(width : CGFloat, font : UIFont) -> CGFloat {
        return _size.boundingRect(with: CGSize(width: width, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).height
    }
}

//MARK:-  Split
public protocol WRStringSplit {
}

fileprivate extension WRStringSplit {
    var _split: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
}

fileprivate typealias WRStringSplit_Public = WRStringSplit
public extension WRStringSplit_Public {
    var unicodeArray: [Int] {
        return _split.unicodeScalars.map { Int($0.value) }
    }

    var words: [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = _split.components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }

}

//MARK:-  Operation
public protocol WRStringOperation {
}

fileprivate extension WRStringOperation {
    var _operation: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
}

fileprivate typealias WRStringOperation_Public = WRStringOperation
public extension WRStringOperation_Public {
    func copyToPasteboard() {
        UIPasteboard.general.string = _operation
    }

    func matches(pattern: String) -> Bool {
        return _operation.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }

}
//MARK:- WRStringProtocol
public protocol WRStringProtocol{

}

extension String : WRStringProtocol {
    public var wr: WRStringExtension {
        return WRStringExtension(self)
    }
}

fileprivate func validate(_ text: String, pattern: String) -> Bool {
    
    do {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: text, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, text.count))
        return matches.count > 0
    }
    catch {
        return false
    }
}

//MARK:- WRStringExtension
public struct WRStringExtension: WRStringJudge, WRStringConversion, WRStringSize, WRStringSplit, WRStringOperation
{
    fileprivate let value: String

    fileprivate init(_ value: String){
        self.value = value
    }
}

fileprivate typealias WRStringExtension_Public = WRStringExtension
public extension WRStringExtension_Public {
    
    var nsString: NSString {
        return NSString(string: value)
    }
    
    var pathExtension: String {
        return nsString.pathExtension
    }
    
    var lastPathComponent: String {
        return nsString.lastPathComponent
    }
    
    var deletingLastPathComponent: String {
        return nsString.deletingLastPathComponent
    }
    
    var deletingPathExtension: String {
        return nsString.deletingPathExtension
    }
    
    var abbreviatingWithTildeInPath: String {
        return nsString.abbreviatingWithTildeInPath
    }
    
    func appendingPathComponent(_ pathComponent: String) -> String {
        return nsString.appendingPathComponent(pathComponent)
    }
    
    func appendingPathExtension(_ pathExtension: String) -> String {
        return nsString.appendingPathExtension(pathExtension) ?? self.value + "." + pathExtension
    }
}

//MARK:- WRNSStringProtocol
@objc public protocol WRNSStringProtocol{
}

 @objc extension NSString : WRNSStringProtocol {
    @objc public override var wr: WRNSStringExtension {
        return WRNSStringExtension(self)
    }

}

//MARK:- WRNSStringExtension
@objc public class WRNSStringExtension : WRObjectExtension, WRStringJudge, WRStringConversion, WRStringSize, WRStringSplit, WRStringOperation
{
    internal init(_ value: NSString){
        super.init(value)
        self.value = value
    }
    
    fileprivate var _string: NSString {
        guard let string = self.value as? NSString else {
            return ""
        }
        return string
    }

}
