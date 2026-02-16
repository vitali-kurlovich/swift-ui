//
//  DateFieldInlinePresentationIntentUpdater.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct DateFieldInlinePresentationIntentUpdater: AttributedStringUpdater {
    public typealias Field = AttributeScopes.FoundationAttributes.DateFieldAttribute.Field

    public let fields: Set<Field>
    public let inline: InlinePresentationIntent

    public init(fields: Set<Field>, inline: InlinePresentationIntent) {
        self.fields = fields
        self.inline = inline
    }

    public func update(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let field = attributes.foundation.dateField else { return }

        if fields.contains(field) {
            string.inlinePresentationIntent = inline
        }
    }
}
