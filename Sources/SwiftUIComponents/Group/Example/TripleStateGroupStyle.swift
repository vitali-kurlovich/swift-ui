//
//  TripleStateGroupStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 13.02.26.
//

import SwiftUI

enum TripleState: Equatable, Sendable, CustomStringConvertible {
    case compact
    case expanded
    case details

    var description: String {
        switch self {
        case .compact:
            return "Compact"
        case .expanded:
            return "Expanded"
        case .details:
            return "Details"
        }
    }

    var next: Self {
        switch self {
        case .compact:
            return .expanded
        case .expanded:
            return .details
        case .details:
            return .compact
        }
    }

    var systemName: String {
        switch self {
        case .compact:
            return "triangle"
        case .expanded:
            return "diamond"
        case .details:
            return "hexagon"
        }
    }

    mutating func toggle() {
        self = next
    }
}

struct TripleStateGroupStyle: StateGroupStyle {
    typealias State = TripleState

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.state.toggle()
                }

            } label: {
                HStack {
                    configuration.label
                    Spacer()
                    Image(systemName: configuration.state.systemName)
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                }.padding()
            }

            if configuration.state != .compact {
                configuration.content
            }
        }
    }
}

@available(macOS 15.0, iOS 18.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview {
    @Previewable @State var state: TripleState = .compact

    StateGroup(state: $state) { _ in
        Label("StateGroup", systemImage: "xmark.triangle.circle.square")

    } content: { state in
        switch state {
        case .compact, .expanded:
            Text("Row 1")
        case .details:
            Text("Row 1")
            Text("Row 2")
            Text("Row 3")
        }
    }
    .stateGroupStyle(TripleStateGroupStyle())

    Form {
        Text(state.description)
    }
}
