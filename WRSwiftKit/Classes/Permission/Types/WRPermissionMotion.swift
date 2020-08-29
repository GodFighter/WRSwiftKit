//
//  WRPermissionMotion.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/8/29.
//

#if PERMISSION_MOTION
import CoreMotion

private let MotionManager = CMMotionActivityManager()

/** 移动数据权限 */
public class WRPermissionMotion: WRPermission {
    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    var requestedMotion: Bool {
        get {
            return UserDefaults.standard.object(forKey: "wrpermission.requestedMotion") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wrpermission.requestedMotion")
        }
    }

    public override var infoKey: String {
        return "NSMotionUsageDescription"
    }

    public override var status: WRPermissionStatus {
        if requestedMotion {
            return synchronousStatusMotion
        }

        return .notDetermined
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        requestedMotion = true

        let now = Date()

        MotionManager.queryActivityStarting(from: now, to: now, to: .main) { _, error in
            let status: WRPermissionStatus

            if  let error = error, error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                status = .denied
            } else {
                status = .authorized
            }

            MotionManager.stopActivityUpdates()

            callback(status)
        }
    }
    
    private var synchronousStatusMotion: WRPermissionStatus {
        let semaphore = DispatchSemaphore(value: 0)

        var status: WRPermissionStatus = .notDetermined

        let now = Date()

        MotionManager.queryActivityStarting(from: now, to: now, to: OperationQueue()) { _, error in
            if  let error = error, error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                status = .denied
            } else {
                status = .authorized
            }

            MotionManager.stopActivityUpdates()

            semaphore.signal()
        }

        _ = semaphore.wait(timeout: .distantFuture)

        return status
    }

}

#endif
