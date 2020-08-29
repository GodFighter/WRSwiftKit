//
//  WRPermissionSiri.swift
//  Pods
//
//  Created by xianghui-iMac on 2020/8/29.
//

#if PERMISSION_SIRI && canImport(Intents)
import Intents

public class WRPermissionSiri: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSSiriUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard #available(iOS 10.0, *) else { fatalError() }

        let status = INPreferences.siriAuthorizationStatus()

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard #available(iOS 10.0, *) else { fatalError() }
//        #if targetEnvironment(simulator)
//        return
//        #endif

        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            print("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        INPreferences.requestSiriAuthorization { _ in
            callback(self.status)
        }
    }
}

#endif
