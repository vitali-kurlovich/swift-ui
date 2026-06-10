//
//  Created by Kurlovich Vitali on 6/9/26.
//

import SwiftUI

public final class LabeledValueBuilder {
    private var currentId: Int = 0

    private var values: [LabeledValue] = []
    private var groupsId: [Int] = []

    public init() {}
}

public extension LabeledValueBuilder {
    func build() -> [LabeledValue] {
        assert(groupsId.isEmpty)
        return values
    }
}

public extension LabeledValueBuilder {
    @discardableResult
    func appendGroup(_ titleKey: LocalizedStringKey, systemImage: String = "") -> Self {
        groupsId.append(currentId)
        return append(LabeledValue(titleKey, id: currentId, systemImage: systemImage, childs: []))
    }

    @discardableResult
    func commitGroup() -> Self {
        let groupId = groupsId.popLast()!

        let index = values.lastIndex { value in
            value.id == groupId
        }!

        let gropValues = values[values.index(after: index)...]

        let titleKey = values[index].titleKey
        let id = values[index].id
        let systemImage = values[index].systemImage

        values = .init(values[values.startIndex ..< index])

        values.append(LabeledValue(titleKey, id: id, systemImage: systemImage, childs: .init(gropValues)))

        return self
    }
}

public extension LabeledValueBuilder {
    @discardableResult
    func append(_ titleKey: LocalizedStringKey, value: String, systemImage: String = "") -> Self {
        append(LabeledValue(titleKey, id: currentId, value: value, systemImage: systemImage))
    }

    @discardableResult
    func append<F: FormatStyle>(_ titleKey: LocalizedStringKey, value: F.FormatInput, format: F, systemImage: String = "") -> Self where F.FormatInput: Equatable, F.FormatOutput == String {
        append(LabeledValue(titleKey, id: currentId, value: value, format: format, systemImage: systemImage))
    }
}

public extension LabeledValueBuilder {
    @discardableResult
    func append(_ titleKey: LocalizedStringKey, value: Bool, systemImage: String = "") -> Self {
        append(titleKey, value: value, format: .boolean, systemImage: systemImage)
    }

    @discardableResult
    func append(_ titleKey: LocalizedStringKey, value: Int, systemImage: String = "") -> Self {
        append(titleKey, value: value, format: .number, systemImage: systemImage)
    }

    @discardableResult
    func append(_ titleKey: LocalizedStringKey, value: Double, systemImage: String = "") -> Self {
        append(titleKey, value: value, format: .number, systemImage: systemImage)
    }

    @discardableResult
    func append(_ titleKey: LocalizedStringKey, value: Float, systemImage: String = "") -> Self {
        append(titleKey, value: value, format: .number, systemImage: systemImage)
    }
}

private extension LabeledValueBuilder {
    func append(_ value: LabeledValue) -> Self {
        defer {
            currentId += 1
        }

        values.append(value)
        return self
    }
}
