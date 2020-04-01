//
//  WRCGFloat.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit
import Foundation

//MARK:- WRCGFloatProtocol
public protocol WRCGFloatProtocol{

}

extension CGFloat : WRCGFloatProtocol {
    public var wr: WRCGFloatExtension {
        return WRCGFloatExtension(self)
    }
}

//MARK:- WRIntExtension
public struct WRCGFloatExtension
{
    fileprivate let value: CGFloat

    fileprivate init(_ value: CGFloat){
        self.value = value
    }
}

fileprivate typealias WRCGFloatExtension_Public = WRCGFloatExtension
public extension WRCGFloatExtension_Public {
    
    var ceil: CGFloat {
        return Foundation.ceil(self.value)
    }
    
    var floor: CGFloat {
        return  Foundation.floor(self.value)
    }
    
    var int: Int {
        return Int(self.value)
    }
    
    var ceilInt: Int {
        return Int(ceil)
    }
    
    var floorInt: Int {
        return Int(floor)
    }

    var float: Float {
        return Float(self.value)
    }

    var double: Double {
        return Double(self.value)
    }

    var string: String {
        return String(format: "%1.2f", self.value)
    }

    func string(_ range: Int = 2) -> String {
        return String(format: "%1.\(range)f", self.value)
    }

}
