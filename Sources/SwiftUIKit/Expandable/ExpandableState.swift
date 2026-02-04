//
//  ExpandableState.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 3.02.26.
//

public enum ExpandableState: Hashable, Sendable {
    case compressed
    case expanded

    mutating func toggle() {
        switch self {
        case .compressed:
            self = .expanded
        case .expanded:
            self = .compressed
        }
    }
}
