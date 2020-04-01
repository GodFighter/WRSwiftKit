//
//  WRReloadEnable.swift
//  Pods
//
//  Created by 项辉 on 2020/4/1.
//

import UIKit

@objc public protocol WRReloadEnable {
    func reloadData() -> Void
    func wr_reloadData(_ completion: @escaping () -> Void ) -> Void
}

@objc extension UITableView: WRReloadEnable {
    @objc public func wr_reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
@objc extension UICollectionView: WRReloadEnable {
    @objc public func wr_reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
