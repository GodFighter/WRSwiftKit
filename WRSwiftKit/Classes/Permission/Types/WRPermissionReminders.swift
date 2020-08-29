//
//  WRPermissionReminders.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/8/29.
//

#if PERMISSION_REMINDERS
import EventKit

/** 记事本权限 */
public class WRPermissionReminders: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSRemindersUsageDescription"
    }

    public override var status: WRPermissionStatus {
        let status = EKEventStore.authorizationStatus(for: .reminder)

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
        EKEventStore().requestAccess(to: .reminder) { _, _ in
            callback(self.status)
        }
    }
}

#endif
