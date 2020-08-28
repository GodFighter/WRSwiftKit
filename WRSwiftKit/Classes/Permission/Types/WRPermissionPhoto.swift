//
//  WRPermissionPhoto.swift
//  Pods
//
//  Created by 项辉 on 2020/8/27.
//

#if PERMISSION_PHOTOS

import Photos

public class WRPermissionPhoto: WRPermission {
    
    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey = "NSPhotoLibraryUsageDescription"
    
    public override var status: WRPermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:          return .authorized
        case .denied, .restricted: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }

    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        PHPhotoLibrary.requestAuthorization { _ in
            callback(self.status)
        }
    }

}

#endif
