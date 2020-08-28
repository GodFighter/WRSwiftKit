//
//  WRPermissionContacts.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_CONTACTS && canImport(Contacts)
import Contacts

/** 通讯录权限 */
public class WRPermissionContacts: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }

    public override var infoKey: String {
        return "NSContactsUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard #available(iOS 9.0, *) else { fatalError() }

        let status = CNContactStore.authorizationStatus(for: .contacts)

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard #available(iOS 9.0, *) else { fatalError() }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        CNContactStore().requestAccess(for: .contacts) { _, _ in
            callback(self.status)
        }
    }
}

#endif
