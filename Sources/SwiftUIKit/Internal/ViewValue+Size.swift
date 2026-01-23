//
//  ViewValue+Size.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 22.01.26.
//

import Foundation

extension ViewValue where BaseType == CGFloat {
    func convertToSize() -> ViewValue<CGSize> {
        switch self {
        case let .fixed(value):
            return .fixed(.init(width: value, height: value))
        case let .dynamic(value):
            return .dynamic(.init(width: value, height: value))
        }
    }
}
