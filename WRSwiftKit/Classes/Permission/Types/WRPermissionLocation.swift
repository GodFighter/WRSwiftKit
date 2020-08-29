//
//  WRPermissionLocation.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/8/29.
//

#if PERMISSION_LOCATION
import CoreLocation

// MARK: - LocationManager
let LocationManager = CLLocationManager()

private var requestedLocation = false
private var triggerCallbacks  = false

extension WRPermission: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch (requestedLocation, triggerCallbacks) {
        case (true, false):
            triggerCallbacks = true
        case (true, true):
            requestedLocation = false
            triggerCallbacks  = false
            self.callback?(self.status)
        default:
            break
        }
    }
}

extension CLLocationManager {
    func request(_ permission: WRPermission) {
        delegate = permission

        requestedLocation = true

        switch permission.type {
        case .locationAlways: requestAlwaysAuthorization()
        case .locationWhenInUse: requestWhenInUseAuthorization()
        default: break
        }
    }
}

// MARK: - LocationWhenInUse
/** 位置权限实例 使用时 */
public class WRPermissionLocationWhenInUse: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSLocationWhenInUseUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else { return .disabled }

        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .authorizedWhenInUse, .authorizedAlways: return .authorized
        case .restricted, .denied:                    return .denied
        case .notDetermined:                          return .notDetermined
        @unknown default:                             return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }
        LocationManager.request(self)
    }
}

// MARK: - LocationAlways
/** 位置权限实例 始终 */
public class WRPermissionLocationAlways: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSLocationAlwaysUsageDescription"
    }

    var requestedLocationAlwaysWithWhenInUse: Bool {
        get {
            return UserDefaults.standard.object(forKey: "wrpermission.requestedLocationAlwaysWithWhenInUse") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wrpermission.requestedLocationAlwaysWithWhenInUse")
        }
    }

    public override var status: WRPermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else { return .disabled }

        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .authorizedAlways: return .authorized
        case .authorizedWhenInUse:
            return requestedLocationAlwaysWithWhenInUse ? .denied : .notDetermined
        case .notDetermined: return .notDetermined
        case .restricted, .denied: return .denied
        @unknown default: return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            requestedLocationAlwaysWithWhenInUse = true
        }
        LocationManager.request(self)
    }
}


#endif
