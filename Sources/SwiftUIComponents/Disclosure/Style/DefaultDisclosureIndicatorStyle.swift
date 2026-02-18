//
//  DefaultDisclosureIndicatorStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

struct DefaultDisclosureIndicatorStyle: DisclosureIndicatorStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.indicator
            .rotationEffect(rotation(for: configuration))
    }
}
