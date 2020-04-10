//
//  WRControl.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit

public typealias wr_control_handler = (UIControl?, UIControl.Event) -> ()

private struct wr_control_associated{
   static var handlerKey = "wr_handler_associated_key"
}

@objc public protocol WRControlProtocol{
}

@objc extension UIControl : WRControlProtocol {
    /**Control事件block扩展方法*/
    /**
    返回控件本身，可链式添加不同响应block，一类事件只有一个block
    */
    /// - parameter event: 事件
    /// - parameter handler: 响应block，返回控件本身和响应的事件
    /// - returns: 控件本身
    @discardableResult
    @objc public func event(_ event: UIControl.Event, handler: @escaping wr_control_handler) -> UIControl? {
        var events = objc_getAssociatedObject(self, &wr_control_associated.handlerKey) as? Dictionary<UInt, Set<WRControlWrapper>>
        if events == nil {
            events = Dictionary<UInt, Set<WRControlWrapper>>.init()
        }
        let key = event.rawValue
        var value = events![key]
        if value == nil {
            value = Set<WRControlWrapper>()
        }
        let wrapper = WRControlWrapper.init(self, event, handler: handler)
        value!.insert(wrapper)
        events![key] = value
        objc_setAssociatedObject(self, &wr_control_associated.handlerKey, events, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addTarget(wrapper, action: #selector(wrapper.invoke(_:)), for: event);

        return self
    }
}

//MARK: -
@objc fileprivate class WRControlWrapper : NSObject {
    var controlEvents : UIControl.Event
    var handler : wr_control_handler
    var sender : UIControl

    init(_ sender: UIControl, _ controlEvents: UIControl.Event, handler: @escaping wr_control_handler) {
        self.sender = sender
        self.controlEvents = controlEvents
        self.handler = handler
    }
    
    @objc func invoke(_ sender : UIControl) {
        self.handler(self.sender, self.controlEvents)
    }
}


