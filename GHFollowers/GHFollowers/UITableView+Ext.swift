//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Mark on 8/25/21.
//

import UIKit

extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }


    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
