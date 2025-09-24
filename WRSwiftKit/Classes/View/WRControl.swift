//
//  WRControl.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/1/14.
//

import UIKit
public typealias WRControlHandler = (UIControl, UIControl.Event) -> Void

private struct WRControlAssociatedKeys {
    static var eventHandlers: Void?
}

@objc public protocol WRControlProtocol {
}

@objc extension UIControl: WRControlProtocol {
    /**
     Control事件block扩展方法
     返回控件本身，可链式添加不同响应block，一类事件只有一个block
     
     - Parameter event: 事件类型
     - Parameter handler: 响应block，返回控件本身和响应的事件
     - Returns: 控件本身
     */
    @discardableResult
    @objc public func event(_ event: UIControl.Event, handler: @escaping WRControlHandler) -> UIControl {
        // 线程安全访问
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        // 获取或创建事件处理器字典
        var eventHandlers = objc_getAssociatedObject(self, &WRControlAssociatedKeys.eventHandlers) as? [UInt: WRControlWrapper]
        if eventHandlers == nil {
            eventHandlers = [UInt: WRControlWrapper]()
        }
        
        let eventRawValue = event.rawValue
        
        // 移除已存在的相同事件处理器
        if let existingWrapper = eventHandlers?[eventRawValue] {
            self.removeTarget(existingWrapper, action: #selector(WRControlWrapper.invoke(_:)), for: event)
        }
        
        // 创建新的包装器
        let wrapper = WRControlWrapper(control: self, event: event, handler: handler)
        eventHandlers?[eventRawValue] = wrapper
        
        // 保存关联对象
        objc_setAssociatedObject(
            self,
            &WRControlAssociatedKeys.eventHandlers,
            eventHandlers,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        
        // 添加目标动作
        self.addTarget(wrapper, action: #selector(WRControlWrapper.invoke(_:)), for: event)
        
        return self
    }
    
    /// 移除指定事件的所有处理器
    @objc public func removeEventHandlers(for event: UIControl.Event) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        guard var eventHandlers = objc_getAssociatedObject(self, &WRControlAssociatedKeys.eventHandlers) as? [UInt: WRControlWrapper] else {
            return
        }
        
        let eventRawValue = event.rawValue
        if let wrapper = eventHandlers[eventRawValue] {
            self.removeTarget(wrapper, action: #selector(WRControlWrapper.invoke(_:)), for: event)
            eventHandlers.removeValue(forKey: eventRawValue)
        }
        
        objc_setAssociatedObject(
            self,
            &WRControlAssociatedKeys.eventHandlers,
            eventHandlers,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
    
    /// 移除所有事件处理器
    @objc public func removeAllEventHandlers() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        guard let eventHandlers = objc_getAssociatedObject(self, &WRControlAssociatedKeys.eventHandlers) as? [UInt: WRControlWrapper] else {
            return
        }
        
        for (eventRawValue, wrapper) in eventHandlers {
            let event = UIControl.Event(rawValue: eventRawValue)
            self.removeTarget(wrapper, action: #selector(WRControlWrapper.invoke(_:)), for: event)
        }
        
        objc_setAssociatedObject(
            self,
            &WRControlAssociatedKeys.eventHandlers,
            nil,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}

// MARK: - Event Wrapper
fileprivate class WRControlWrapper: NSObject {
    private weak var control: UIControl?
    private let event: UIControl.Event
    private let handler: WRControlHandler
    
    init(control: UIControl, event: UIControl.Event, handler: @escaping WRControlHandler) {
        self.control = control
        self.event = event
        self.handler = handler
        super.init()
    }
    
    @objc func invoke(_ sender: UIControl) {
        // 使用可选绑定确保control存在
        if let control = self.control {
            handler(control, event)
        }
    }
    
    deinit {
        #if DEBUG
        print("WRControlWrapper deinit for event: \(event)")
        #endif
    }
}


