//
//  WRStirng+Judge.swift
//  Pods
//
//  Created by 项辉 on 2020/9/22.
//

import UIKit

public protocol WRStringJudge { }

public extension WRStringJudge {
    fileprivate var _judge: String {
        if self is String {
            return self as! String
        } else if let `self` = self as? WRStringExtension{
            return self.value
        }
        return ""
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
}

fileprivate typealias WRStringJudge_Public = WRStringJudge
public extension WRStringJudge_Public {
    /// 是否为ip
    ///
    ///     let ip  = "192.168.2.2"
    ///     // Prints: true
    ///     let ip  = "192.1628.2.2"
    ///     // Prints: false
    ///
    var isIP : Bool {
        return validate(_judge, pattern: "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    }
    
    /// 是否为URL
    ///
    ///     let http = "https://www.baidu.com"
    ///     // Prints: true
    ///
    var isUrl : Bool {
        return validate(_judge, pattern:  "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
    }

    /// 是否为email
    ///
    ///     let email = "58626111@qq.com"
    ///     // Prints: true
    ///
    var isEmail : Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"

        return validate(_judge, pattern: regex)
    }

    /// 是否为手机号
    ///
    ///     let phoneNumber = "13191438151"
    ///     // Prints: true
    ///
    var isPhoneNumber : Bool {
        return validate(_judge, pattern: "^(1)\\d{10}$")
    }

    /// 是否为车牌号
    ///
    ///     let carNumber = "NUM631"
    ///     // Prints: true
    ///
    var isCar: Bool {
        return validate(_judge, pattern: "^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    /// 是否为英文字母
    ///
    ///     let letter = "NUM631"
    ///     // Prints: false
    ///
    var isAlphabet: Bool {
        return !_judge.isEmpty && _judge.range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    /// 是否为数字
    ///
    ///     let number = "NUM631"
    ///     // Prints: false
    ///
    var isNumber: Bool {
        return !_judge.isEmpty && _judge.range(of: "[0-9]*", options: .regularExpression) == nil
    }
    
    /// 是否为蒙文字母
    ///
    ///     let mongolian = "ᠵᠠᠯᠠᠷᠠᠭᠤᠯᠬᠤ"
    ///     // Prints: true
    ///
    var isMongolian: Bool {
        return !_judge.isEmpty && (Int(_judge.unicodeScalars.first?.value ?? 0) >= 0x1800 && Int(_judge.unicodeScalars.first?.value ?? 0) <= 0x18AF)
    }
}
