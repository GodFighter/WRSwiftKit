//
//  WRInt.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit

//MARK:- WRIntProtocol
public protocol WRIntProtocol{

}

extension Int : WRIntProtocol {
    public var wr: WRIntExtension {
        return WRIntExtension(self)
    }
}

//MARK:- WRIntExtension
public struct WRIntExtension
{
    fileprivate let value: Int

    fileprivate init(_ value: Int){
        self.value = value
    }
}

fileprivate typealias WRIntExtension_Public = WRIntExtension
public extension WRIntExtension_Public {
    var uInt: UInt {
        return UInt(self.value)
    }

    var double: Double {
        return Double(self.value)
    }

    var float: Float {
        return Float(self.value)
    }

    var cgFloat: CGFloat {
        return CGFloat(self.value)
    }
    
    var string: String {
        return String(format: "%i", self.value)
    }

}
