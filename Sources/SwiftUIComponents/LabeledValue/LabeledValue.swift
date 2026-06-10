//
//  Created by Kurlovich Vitali on 6/7/26.
//

import Playgrounds
import SwiftUI

public struct LabeledValue: Equatable, Identifiable {
    public let id: Int
    public let titleKey: LocalizedStringKey
    public let isGroup: Bool
    public let value: String
    public let systemImage: String

    public var childs: [LabeledValue]?

    public init(_ titleKey: LocalizedStringKey, id: Int, isGroup: Bool = false, value: String, systemImage: String = "", childs: [LabeledValue]? = nil) {
        self.id = id
        self.titleKey = titleKey
        self.value = value
        self.isGroup = isGroup
        self.systemImage = systemImage
        self.childs = childs
    }
}

public extension LabeledValue {
    init<F>(_ titleKey: LocalizedStringKey, id: Int, value: F.FormatInput, format: F, systemImage: String = "") where F: FormatStyle, F.FormatInput: Equatable, F.FormatOutput == String {
        self.init(titleKey, id: id, value: format.format(value), systemImage: systemImage)
    }

    init(_ titleKey: LocalizedStringKey, id: Int, systemImage: String = "", childs: [LabeledValue]) {
        self.init(titleKey, id: id, isGroup: true, value: "", systemImage: systemImage, childs: childs)
    }
}
