//
//  ExpandableView+ButtonLabel.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 26.01.26.
//

import SwiftUI

enum ButtonLabel {
    case empty
    case titleKey(LocalizedStringKey)
    case titleKeySystemImage(LocalizedStringKey, String)

    case titleKeyImageResource(LocalizedStringKey, ImageResource)
}
