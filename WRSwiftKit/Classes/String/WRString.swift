//
//  WRString.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

//MARK:-  Size
public protocol WRStringSize { }

fileprivate extension WRStringSize {
    var _size: String {
        if self is String || self is NSString {
            return self as! String
        } else if let `self` = self as? WRStringExtension{
            return self.value
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



//MARK:-  Operation
public protocol WRStringOperation { }

fileprivate extension WRStringOperation {
    var _operation: String {
        if self is String || self is NSString {
            return self as! String
            } else if let `self` = self as? WRStringExtension{
            return self.value
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
public protocol WRStringProtocol { }

extension String : WRStringProtocol {
    public var wr: WRStringExtension {
        return WRStringExtension(self)
    }
}


//MARK:- WRStringExtension
public struct WRStringExtension: WRStringJudge, WRStringConversion, WRStringSize, WRStringSeparate, WRStringOperation
{
    internal let value: String

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
