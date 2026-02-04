//
//  ExpandableView+DefaultExpandableViewHeader.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 26.01.26.
//

import SwiftUI

// ExpandableView+DefaultExpandableViewHeader

extension ExpandableView where Header == DefaultExpandableViewHeader {
    init(_ state: Binding<ExpandableState>,
         disclosureIndicator: DisclosureIndicator,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(state,
                  header: DefaultExpandableViewHeader(),
                  disclosureIndicator: disclosureIndicator,
                  content: content)
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         disclosureIndicator: DisclosureIndicator,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(
            buttonLabel: .titleKey(titleKey),
            state: state,
            header: DefaultExpandableViewHeader(),
            disclosureIndicator: disclosureIndicator,
            content: content
        )
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         disclosureIndicator: DisclosureIndicator,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(
            buttonLabel: .titleKeySystemImage(titleKey, systemImage),
            state: state,
            header: DefaultExpandableViewHeader(),
            disclosureIndicator: disclosureIndicator,
            content: content
        )
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         disclosureIndicator: DisclosureIndicator,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(
            buttonLabel: .titleKeyImageResource(titleKey, image),
            state: state,
            header: DefaultExpandableViewHeader(),
            disclosureIndicator: disclosureIndicator,
            content: content
        )
    }
}
