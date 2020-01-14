//
//  WRObject.swift
//  Pods
//
//  Created by 项辉 on 2020/1/14.
//

import UIKit

@objc public protocol WRObjectProtocol{
    var wr: WRObjectExtension { get }
}

@objc extension NSObject : WRObjectProtocol {
    @objc public var wr: WRObjectExtension {
        return WRObjectExtension(self)
    }
}

@objc public class WRObjectExtension : NSObject {
    internal var value: NSObject

    internal init(_ value: NSObject){
        self.value = value
    }
}
