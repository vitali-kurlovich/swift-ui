//
//  ExpandableViewDisclosureIndicator.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 26.01.26.
//

import SwiftUI

protocol ExpandableViewDisclosureIndicator {
    associatedtype Body: View

    func makeBody(configuration: ExpandableViewStyleConfiguration) -> Body
}

struct DefaultDisclosureIndicator: ExpandableViewDisclosureIndicator {
    func makeBody(configuration: ExpandableViewStyleConfiguration) -> some View {
        AspectRatioLayout(aspectRatio: 1) {
            Image(systemName: "chevron.forward")
        }.padding(4)
            .rotationEffect(configuration.state == .expanded ? .degrees(90) : .degrees(0))
            .background {
                Circle().fill(.ultraThinMaterial)
            }
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

#Preview {
    @Previewable @State var state: ExpandableState = .compressed
    ZStack {
        ExpandableView($state, "Header") { state in
            VStack {
                switch state {
                case .compressed:
                    Text("Row 1").id(1)
                case .expanded:
                    Text("Row 1").id(1)
                    Text("Row 2").id(2)
                    Button("Row 3", systemImage: "chevron.forward") {}.id(3)
                }
            }
        }

    }.padding(60)
}
