//
//  WRPermissionNotifications.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_NOTIFICATIONS
import UserNotifications

/** 通知权限 iOS10+ */
public class WRPermissionNotifications: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    // 缓存权限
    var requestedNotifications: Bool {
        get {
            return UserDefaults.standard.object(forKey: "wrpermission.requestedNotifications") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wrpermission.requestedNotifications")
        }
    }

    public override var status: WRPermissionStatus {
        if requestedNotifications {
            return synchronousStatusNotifications
        }
        return .notDetermined
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard #available(iOS 10.0, *) else { fatalError() }

        guard case .notifications(let options) = type else { fatalError() }

        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            self.requestedNotifications = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                callback(self.status)
            }
        }
    }
    
    private var synchronousStatusNotifications: WRPermissionStatus {
        guard #available(iOS 10.0, *) else { fatalError() }
        
        let semaphore = DispatchSemaphore(value: 0)

        var status: WRPermissionStatus = .notDetermined

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: status = .authorized
            case .denied: status = .denied
            case .notDetermined: status = .notDetermined
            case .provisional: status = .authorized
            @unknown default: status = .notDetermined
            }

            semaphore.signal()
        }

        _ = semaphore.wait(timeout: .distantFuture)

        return status
    }

}

#endif
