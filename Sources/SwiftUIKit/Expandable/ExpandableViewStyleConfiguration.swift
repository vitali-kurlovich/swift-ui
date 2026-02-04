//
//  ExpandableViewStyleConfiguration.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 3.02.26.
//

import SwiftUI

public struct ExpandableViewStyleConfiguration {
    private let configuration: ButtonStyle.Configuration

    public let state: ExpandableState
}

public extension ExpandableViewStyleConfiguration {
    var isPressed: Bool {
        configuration.isPressed
    }

    var label: ButtonStyleConfiguration.Label {
        configuration.label
    }
}

extension ExpandableViewStyleConfiguration {
    init(_ configuration: ButtonStyle.Configuration, state: ExpandableState) {
        self.configuration = configuration
        self.state = state
    }
}
