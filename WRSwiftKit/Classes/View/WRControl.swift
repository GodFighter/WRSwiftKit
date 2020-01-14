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
    @objc func event(_ event: UIControl.Event, handler: @escaping wr_control_handler) -> UIControl?
}

@objc extension UIControl : WRControlProtocol {
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
        let wrapper = WRControlWrapper.init(event, handler: handler)
        value!.insert(wrapper)
        events![key] = value
        objc_setAssociatedObject(self, &wr_control_associated.handlerKey, events, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addTarget(wrapper, action: #selector(wrapper.invoke(_:)), for: event);

        return self
    }
}

@objc public class WRControlExtension : WRViewExtension {

}

//MARK: -
@objc fileprivate class WRControlWrapper : NSObject {
    var controlEvents : UIControl.Event
    var handler : wr_control_handler
    
    init(_ controlEvents: UIControl.Event, handler: @escaping wr_control_handler) {
        self.controlEvents = controlEvents
        self.handler = handler
    }
    
    @objc func invoke(_ sender : UIControl) {
        self.handler(sender, self.controlEvents)
    }
}


