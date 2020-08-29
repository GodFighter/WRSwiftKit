//
//  WRPermissionSpeech.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_SPEECH_RECOGNIZER && canImport(Speech)
import Speech

/** 语音录制权限 */
public class WRPermissionSpeech: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSSpeechRecognitionUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard #available(iOS 10.0, *) else { fatalError() }

        let status = SFSpeechRecognizer.authorizationStatus()

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard #available(iOS 10.0, *) else { fatalError() }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") else {
            debugPrint("WARNING: \("NSMicrophoneUsageDescription") not found in Info.plist")
            return
        }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { _ in
            callback(self.status)
        }
    }
}

#endif
