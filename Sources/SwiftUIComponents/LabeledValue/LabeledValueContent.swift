//
//  Created by Kurlovich Vitali on 6/7/26.
//

import SwiftUI

struct LabeledValueContent: View {
    let label: LabeledValue

    var body: some View {
        if label.isGroup {
            if label.systemImage.isEmpty {
                Text(label.titleKey)
            } else {
                Label(label.titleKey, systemImage: label.systemImage)
            }

        } else {
            #if os(macOS)
                Text(label.value)
            #else

                if label.systemImage.isEmpty {
                    LabeledContent(label.titleKey, value: label.value)
                } else {
                    LabeledContent {
                        Text(label.value)
                    } label: {
                        Label(label.titleKey, systemImage: label.systemImage)
                    }
                }

            #endif
        }
    }
}
