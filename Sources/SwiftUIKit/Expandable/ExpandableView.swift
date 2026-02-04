//
//  ExpandableView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 16.01.26.
//

import SwiftUI

struct ExpandableView<Header: ExpandableViewHeader, DisclosureIndicator: ExpandableViewDisclosureIndicator, Content: View>: View {
    private let header: Header
    private let disclosureIndicator: DisclosureIndicator
    private let content: (ExpandableState) -> Content

    private let buttonLabel: ButtonLabel

    init(
        buttonLabel: ButtonLabel,
        state: Binding<ExpandableState>,

        header: Header,
        disclosureIndicator: DisclosureIndicator,
        content: @escaping (ExpandableState) -> Content
    ) {
        _state = state
        self.header = header
        self.disclosureIndicator = disclosureIndicator
        self.content = content

        self.buttonLabel = buttonLabel
    }

    @Binding
    var state: ExpandableState

    var body: some View {
        VStack {
            button()
                .buttonStyle(buttonStyle)
            content(state)
        }
    }
}

private extension ExpandableView {
    var buttonStyle: ExpandableButtonStyle {
        ExpandableButtonStyle(state: state, header: header, disclosureIndicator: disclosureIndicator)
    }

    func action() {
        withAnimation {
            state.toggle()
        }
    }

    @ViewBuilder func button() -> some View {
        switch buttonLabel {
        case .empty:
            Button("", action: action)
        case let .titleKey(localizedKey):
            Button(localizedKey, action: action)
        case let .titleKeySystemImage(localizedKey, systemImage):
            Button(localizedKey, systemImage: systemImage, action: action)
        case let .titleKeyImageResource(localizedKey, imageResource):
            Button(localizedKey, image: imageResource, action: action)
        }
    }
}

extension ExpandableView {
    init(_ state: Binding<ExpandableState>,
         header: Header,
         disclosureIndicator: DisclosureIndicator,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(
            buttonLabel: .empty,
            state: state,
            header: header,
            disclosureIndicator: disclosureIndicator,
            content: content
        )
    }
}

extension ExpandableView {
    struct ExpandableButtonStyle: ButtonStyle {
        let state: ExpandableState

        let header: Header
        let disclosureIndicator: DisclosureIndicator

        func makeBody(configuration: ButtonStyle.Configuration) -> some View {
            let configuration = ExpandableViewStyleConfiguration(configuration, state: state)

            return withAnimation {
                HStack {
                    header.makeBody(configuration: configuration)

                    disclosureIndicator.makeBody(configuration: configuration)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var state: ExpandableState = .compressed
    ZStack {
        ExpandableView($state, "Header") { state in
            switch state {
            case .compressed:
                Text("Row 1")
            case .expanded:
                Text("Row 1")
                Text("Row 2")
                Button("Row 3", systemImage: "chevron.forward") {}
            }
        }

    }.padding(60)
}
