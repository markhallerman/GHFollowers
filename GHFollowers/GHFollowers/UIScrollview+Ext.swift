//
//  UIScrollview+Ext.swift
//  GHFollowers
//
//  Created by Mark on 8/17/21.
//

import UIKit

extension UIScrollView {
    
    func hasReachedEndOfScrollView() -> Bool {
        let offsetY = self.contentOffset.y
        let contentHeight = self.contentSize.height
        let height = self.frame.size.height

        if offsetY > contentHeight - height {
            return true
        }

        return false
    }
}
