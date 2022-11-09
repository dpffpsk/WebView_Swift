//
//  CGPoint.swift
//  webView_swift
//
//  Created by wons on 2022/11/08.
//

import Foundation

extension CGPoint {
    
    // MARK: - CGPoint+offsetBy
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        var point = self
        point.x += dx
        point.y += dy
        return point
    }
}
