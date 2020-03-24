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
    fileprivate var judge: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }
    
    var isIP : Bool {
        return validate(self.judge, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    
    var isUrl : Bool {
        return validate(self.judge, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }

    var isEmail : Bool {
        if self.judge.contains("@qq.com") {
            return validate(self.judge, pattern: "^([0-9]{5,11})@qq.com")
        }
        return validate(self.judge, pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }

    var isPhoneNumber : Bool {
        return validate(self.judge, pattern: "^(1)\\d{10}$")
    }

    var isCar: Bool {
        return validate(self.judge, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }

}

//MARK:-  Conversion
public protocol WRStringConversion {
}

public extension WRStringConversion {
    fileprivate var conversion: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }

    var html: String? {
        guard let data = self.conversion.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string
    }

    var stripXml: String {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escaped = (self.conversion as String).replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped
    }

    var stripHtml: String {
        return self.conversion.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }

    var stripLineBreaks: String {
        return self.conversion.replacingOccurrences(of: "\n", with: "", options: .regularExpression)
    }
}

//MARK:-  Size
public protocol WRStringSize {
}

public extension WRStringSize {
    fileprivate var size: String {
        if self is String || self is NSString {
            return self as! String
        } else if let stringExtension = self as? WRStringExtension{
            return stringExtension.value
        } else if let nsstringExtension = self as? WRNSStringExtension{
            return nsstringExtension.value as! String
        }
        return ""
    }

    func width(_ font : UIFont) -> CGFloat {
        return self.size.boundingRect(with: CGSize(), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).width
    }

    func height(width : CGFloat, font : UIFont) -> CGFloat {
        return self.size.boundingRect(with: CGSize(width: width, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).height
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

//MARK:-
public struct WRStringExtension: WRStringJudge, WRStringConversion, WRStringSize
{
    fileprivate let value: String

    fileprivate init(_ value: String){
        self.value = value
    }

    //MARK: path
    public var pathExtension: String {
        return (self.value as NSString).pathExtension
    }
    
    public var lastPathComponent: String {
        return (self.value as NSString).lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return (self.value as NSString).deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return (self.value as NSString).deletingPathExtension
    }
    
    public var abbreviatingWithTildeInPath: String {
        return (self.value as NSString).abbreviatingWithTildeInPath
    }
    
    public func appendingPathComponent(_ pathComponent: String) -> String {
        return (self.value as NSString).appendingPathComponent(pathComponent)
    }
    
    public func appendingPathExtension(_ pathExtension: String) -> String {
        return (self.value as NSString).appendingPathExtension(pathExtension) ?? self.value + "." + pathExtension
    }
}


//MARK:-
@objc public protocol WRNSStringProtocol{
}

 @objc extension NSString : WRNSStringProtocol {
    @objc public override var wr: WRNSStringExtension {
        return WRNSStringExtension(self)
    }
}

//MARK:-
@objc public class WRNSStringExtension : WRObjectExtension, WRStringJudge, WRStringConversion, WRStringSize
{
    internal init(_ value: NSString){
        super.init(value)
        self.value = value
    }
}
