//
//  DefaultStateGroupStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 13.02.26.
//

import SwiftUI

struct DefaultStateGroupStyle<State: Equatable>: StateGroupStyle, Equatable {
    init() {}

    func makeBody(configuration: StateGroupStyleConfiguration<State>) -> some View {
        VStack {
            configuration.label
            configuration.content
        }
    }
}
