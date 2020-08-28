//
//  WRPermissionMicrophone.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_MICROPHONE
import AVFoundation

/** 麦克风权限 */
public class WRPermissionMicrophone: WRPermission {
    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSMicrophoneUsageDescription"
    }

    public override var status: WRPermissionStatus {
        let status = AVAudioSession.sharedInstance().recordPermission

        switch status {
        case .denied:  return .denied
        case .granted: return .authorized
        default:       return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }
        AVAudioSession.sharedInstance().requestRecordPermission { _ in
            callback(self.status)
        }
    }
}

#endif
