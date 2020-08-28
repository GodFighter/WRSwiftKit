//
//  WRPermissionMediaLibrary.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_MEDIA_LIBRARY
import MediaPlayer

/** 媒体库权限 iOS 9.3 */
public class WRPermissionMediaLibrary: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSAppleMusicUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard #available(iOS 9.3, *) else { fatalError() }

        let status = MPMediaLibrary.authorizationStatus()

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard #available(iOS 9.3, *) else { fatalError() }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        MPMediaLibrary.requestAuthorization { _ in
            callback(self.status)
        }
    }
}

#endif
