//
//  WRFloat.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit

//MARK:- WRFloatExtension
extension FloatingPoint {
    public var wr: WRFloatExtension {
        return WRFloatExtension(self)
    }
}

public struct WRFloatExtension
{
    fileprivate let value: Any

    fileprivate init(_ value: Any){
        self.value = value
    }
    
    fileprivate var _float: Float {
        guard let float = self.value as? Float else {
            return Float(0)
        }
        return float
    }
}

fileprivate typealias WRFloatExtension_Public = WRFloatExtension
public extension WRFloatExtension_Public {
    
    var ceil: Float {
        return ceilf(_float)
    }
    
    var floor: Float {
        return floorf(_float)
    }
    
    var int: Int {
        return Int(_float)
    }
    
    var ceilInt: Int {
        return Int(ceilf(_float))
    }
    
    var floorInt: Int {
        return Int(floorf(_float))
    }

    var double: Double {
        return Double(_float)
    }

    var cgFloat: CGFloat {
        return CGFloat(_float)
    }

    var string: String {
        return String(format: "%1.2f", _float)
    }

    func string(_ range: Int = 2) -> String {
        return String(format: "%1.\(range)f", _float)
    }
}

