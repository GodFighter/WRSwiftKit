//
//  WRPermissionEvents.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/8/29.
//

#if PERMISSION_EVENTS
import EventKit

/** 日历权限 */
public class WRPermissionEvents: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSCalendarsUsageDescription"
    }

    public override var status: WRPermissionStatus {
        let status = EKEventStore.authorizationStatus(for: .event)

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        EKEventStore().requestAccess(to: .event) { _, _ in
            callback(self.status)
        }
    }
}

#endif
