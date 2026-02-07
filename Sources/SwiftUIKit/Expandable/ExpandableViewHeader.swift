//
//  ExpandableViewHeader.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 26.01.26.
//

import SwiftUI

protocol ExpandableViewHeader {
    associatedtype Body: View

    func makeBody(configuration: ExpandableViewStyleConfiguration) -> Body
}

struct DefaultExpandableViewHeader: ExpandableViewHeader {
    func makeBody(configuration: ExpandableViewStyleConfiguration) -> some View {
        configuration.label.opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

struct ExpandableViewHeaderContent<LabelContent, DisclosureIndicator>: ExpandableViewHeader {
    func makeBody(configuration: ExpandableViewStyleConfiguration) -> some View {
        configuration.label.opacity(configuration.isPressed ? 0.3 : 1.0)
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
