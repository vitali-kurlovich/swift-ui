//
//  ExpandableView+DefaultDisclosureIndicator.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 26.01.26.
//

import SwiftUI

extension ExpandableView where Header == DefaultExpandableViewHeader, DisclosureIndicator == DefaultDisclosureIndicator {
    init(_ state: Binding<ExpandableState>,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(state,
                  disclosureIndicator: DefaultDisclosureIndicator(),
                  content: content)
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(state, titleKey,
                  disclosureIndicator: DefaultDisclosureIndicator(),
                  content: content)
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         systemImage: String,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(state, titleKey, systemImage: systemImage,
                  disclosureIndicator: DefaultDisclosureIndicator(),
                  content: content)
    }

    init(_ state: Binding<ExpandableState>,
         _ titleKey: LocalizedStringKey,
         image: ImageResource,
         @ViewBuilder content: @escaping (ExpandableState) -> Content)
    {
        self.init(state, titleKey, image: image,
                  disclosureIndicator: DefaultDisclosureIndicator(),
                  content: content)
    }
}
