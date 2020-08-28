//
//  WRPermissionCamera.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_CAMERA

import AVFoundation

/** 相机权限 */
public class WRPermissionCamera: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSCameraUsageDescription"
    }

    public override var status: WRPermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

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

        AVCaptureDevice.requestAccess(for: .video) { _ in
            callback(self.status)
        }
    }

}

#endif
