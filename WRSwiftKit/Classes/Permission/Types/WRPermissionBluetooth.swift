//
//  WRPermissionBluetooth.swift
//  Pods
//
//  Created by 项辉 on 2020/8/28.
//

#if PERMISSION_BLUETOOTH
import CoreBluetooth

let WRBluetoothManager = CBPeripheralManager(
    delegate: WRPermission.Bluetooth,
    queue: nil,
    options: [CBPeripheralManagerOptionShowPowerAlertKey: false]
)

public class WRPermissionBluetooth: WRPermission {

    override init(type: WRPermissionType) {
        super.init(type: type)
    }
    
    var requestedBluetooth: Bool {
        get {
            return UserDefaults.standard.object(forKey: "wrpermission.requestedBluetooth") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wrpermission.requestedBluetooth")
        }
    }

    var stateBluetoothManagerDetermined: Bool {
        get {
            return UserDefaults.standard.object(forKey: "wrpermission.stateBluetoothManagerDetermined") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wrpermission.stateBluetoothManagerDetermined")
        }
    }
    
    var statusBluetooth: WRPermissionStatus? {
        get {
            let statusStirng = UserDefaults.standard.object(forKey: "wrpermission.statusBluetooth") as? String ?? nil
            return WRPermissionStatus.init(string: statusStirng)
        }
        set {
            UserDefaults.standard.set(newValue?.description, forKey: "wrpermission.statusBluetooth")
        }
    }

    public override var infoKey: String {
        return "NSBluetoothAlwaysUsageDescription"
    }

    public override var status: WRPermissionStatus {
        guard #available(iOS 13.0, *) else {
            switch CBPeripheralManager.authorizationStatus() {
            case .restricted:                 return .disabled
            case .denied:                     return .denied
            case .notDetermined, .authorized: break
            @unknown default:                 return .notDetermined
            }
            return .notDetermined
        }
        guard stateBluetoothManagerDetermined else { return .notDetermined }

        switch WRBluetoothManager.state {
        case .unsupported, .poweredOff: return .disabled
        case .unauthorized: return .denied
        case .poweredOn: return .authorized
        case .resetting, .unknown:
            return statusBluetooth ?? .notDetermined
        @unknown default: return .notDetermined
        }
    }
    
    public override func request(_ callback: @escaping Callback) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: infoKey) else {
            debugPrint("WARNING: \(infoKey) not found in Info.plist")
            return
        }

        requestedBluetooth = true
        WRBluetoothManager.request(self)
    }
}

extension WRPermissionBluetooth: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        stateBluetoothManagerDetermined = true
        statusBluetooth = status

        guard requestedBluetooth else { return }

        callback?(self.status)

        requestedBluetooth = false
    }
}

extension CBPeripheralManager {
    func request(_ permission: WRPermissionBluetooth) {
        guard case .poweredOn = state else { return }

        startAdvertising(nil)
        stopAdvertising()
    }
}

#endif
