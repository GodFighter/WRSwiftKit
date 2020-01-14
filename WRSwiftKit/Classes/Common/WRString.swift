//
//  WRString.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

//MARK:-
public protocol WRStringProtocol{
    var wr: WRStringExtension { get }
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
public struct WRStringExtension{
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
    
    //MARK:  Regular
    public var isIP : Bool {
        return validate(self.value, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    public var isUrl : Bool {
        return validate(self.value, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    public var isEmail : Bool {
        if self.value.contains("@qq.com") {
            return validate(self.value, pattern: "^([0-9]{5,11})@qq.com")
        }
        return validate(self.value, pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    public var isPhone : Bool {
        return validate(self.value, pattern: "^(1)\\d{10}$")
    }
    public var isCar: Bool {
        return validate(self.value, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }

    //MARK:  Conversion
    public var htmlString : String? {
        guard let data = self.value.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string
    }
    
    public var stripXml: String {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escaped = self.value.replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped
    }

    public var stripHtml: String {
        return self.value.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }

    public var stripLineBreaks: String {
        return self.value.replacingOccurrences(of: "\n", with: "", options: .regularExpression)
    }

    //MARK:  Size
    public func width(_ font : UIFont) -> CGFloat {
        return self.value.boundingRect(with: CGSize(), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).width
    }

    public func height(width : CGFloat, font : UIFont) -> CGFloat {
        return self.value.boundingRect(with: CGSize(width: width, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).height
    }
}


//MARK:-
@objc public protocol WRNSStringProtocol{
    var wr: WRNSStringExtension { get }
}

 @objc extension NSString : WRNSStringProtocol {
    @objc public override var wr: WRNSStringExtension {
        return WRNSStringExtension(self)
    }
}

//MARK:-
@objc public class WRNSStringExtension : WRObjectExtension{
    
    internal init(_ value: NSString){
        super.init(value)
        self.value = value
    }
    
    fileprivate var string : NSString {
        if let string = self.value as? NSString {
            return string
        }
        return ""
    }

    @objc public func appendingPathComponent(_ pathComponent: String) -> NSString {
        return self.string.appendingPathComponent(pathComponent) as NSString
    }

    @objc public  func appendingPathExtension(_ pathExtension: String) -> NSString {
        return self.string.appendingPathExtension(pathExtension) as NSString? ?? (self.string as String) + "." + pathExtension as NSString
    }

    //MARK:  Regular
    @objc public  var isIP : Bool {
        return validate(self.string as String, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    @objc public  var isUrl : Bool {
        return validate(self.string as String, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }
    @objc public  var isEmail : Bool {
        if self.string.range(of: "@qq.com").length > 0 {
            return validate(self.string as String, pattern: "^([0-9]{5,11})@qq.com")
        }
        return validate(self.string as String, pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    @objc public  var isPhone : Bool {
        return validate(self.string as String, pattern: "^(1)\\d{10}$")
    }
    @objc public  var isCar: Bool {
        return validate(self.string as String, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }

    //MARK:  Conversion
    @objc public  var htmlString : NSString? {
        guard let data = (self.string as String).data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html.string as NSString
    }
    
    @objc public  var stripXml: NSString {
        // we need to make sure "&" is escaped first. Not doing this may break escaping the other characters
        var escaped = (self.string as String).replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        // replace the other four special characters
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped as NSString
    }

    @objc public  var stripHtml: NSString {
        return (self.string as String).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) as NSString
    }

    @objc public  var stripLineBreaks: NSString {
        return (self.string as String).replacingOccurrences(of: "\n", with: "", options: .regularExpression) as NSString
    }

    //MARK:  Size
    @objc public  func width(_ font : UIFont) -> CGFloat {
        return (self.string as String).boundingRect(with: CGSize(), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).width
    }

    @objc public  func height(width : CGFloat, font : UIFont) -> CGFloat {
        return (self.string as String).boundingRect(with: CGSize(width: width, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).height
    }

}
