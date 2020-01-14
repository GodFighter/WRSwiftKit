//
//  WRTimeInterval.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

public protocol WRTimeIntervalProtocol{
    var wr: WRTimeIntervalExtension { get }
}

extension TimeInterval : WRTimeIntervalProtocol {
    public var wr: WRTimeIntervalExtension {
        return WRTimeIntervalExtension(self)
    }
}

public struct WRTimeIntervalExtension{
    fileprivate let value: TimeInterval

    fileprivate init(_ value: TimeInterval){
        self.value = value
    }
    
    /**时间字符串*/
    /**
    00:00:00 和 00:00 格式
    */
    /// - parameter unit: 时间字符串格式
    /// - returns: 时间字符串
    public func durationString(_ unit : NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = unit
        formatter.zeroFormattingBehavior = .pad
        if self.value.isNaN {
            return ""
        }
        return formatter.string(from: self.value)!
    }

}
