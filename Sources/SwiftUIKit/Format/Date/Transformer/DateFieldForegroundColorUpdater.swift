//
//  DateFieldForegroundColorUpdater.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 17.02.26.
//

import SwiftUI

public struct DateFieldForegroundColorUpdater: AttributedStringUpdater {
    public typealias Field = AttributeScopes.FoundationAttributes.DateFieldAttribute.Field
    private var storage: [Field: Color]

    public init(_ colors: [Field: Color] = [:]) {
        storage = colors
    }

    public func update(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let field = attributes.foundation.dateField else { return }

        if let color = storage[field] {
            string.foregroundColor = color
        }
    }

    public subscript(field: Field) -> Color? {
        get {
            storage[field]
        }
        set(newValue) {
            storage[field] = newValue
        }
    }
}
