//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct DateFieldInlinePresentationIntentModifier: AttributedStringModifier {
    public typealias Field = AttributeScopes.FoundationAttributes.DateFieldAttribute.Field

    public let fields: Set<Field>
    public let inline: InlinePresentationIntent

    public init(fields: Set<Field>, inline: InlinePresentationIntent) {
        self.fields = fields
        self.inline = inline
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let field = attributes.foundation.dateField else { return }

        if fields.contains(field) {
            string.inlinePresentationIntent = inline
        }
    }
}
