//
//  WRDouble.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit
import Foundation

public struct WRDoubleExtension
{
    fileprivate let value: Any

    fileprivate init(_ value: Any){
        self.value = value
    }
    
    fileprivate var _double: Double {
        guard let double = self.value as? Double else {
            return Double(0)
        }
        return double
    }
}

fileprivate typealias WRDoubleExtension_Public = WRDoubleExtension
public extension WRDoubleExtension_Public {
    
    var ceil: Double {
        return Foundation.ceil(_double)
    }
    
    var floor: Double {
        return  Foundation.floor(_double)
    }
    
    var int: Int {
        return Int(_double)
    }
    
    var ceilInt: Int {
        return Int(ceil)
    }
    
    var floorInt: Int {
        return Int(floor)
    }

    var float: Float {
        return Float(_double)
    }

    var cgFloat: CGFloat {
        return CGFloat(_double)
    }

    var string: String {
        return String(format: "%1.2f", _double)
    }

    func string(_ range: Int = 2) -> String {
        return String(format: "%1.\(range)f", _double)
    }

}

