//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation
import SwiftUI

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

public extension FormatStyle where Self.FormatInput == Date, Self.FormatOutput == AttributedString {
    @inlinable func modify(inline: InlinePresentationIntent, for fields: Set<AttributeScopes.FoundationAttributes.DateFieldAttribute.Field>) ->

        AttributedStringTransformerStyle<Date, Self, AttributedStringModifierTransformer<DateFieldInlinePresentationIntentModifier>>
    {
        let modifier = DateFieldInlinePresentationIntentModifier(fields: fields, inline: inline)
        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(inline: InlinePresentationIntent, for field: AttributeScopes.FoundationAttributes.DateFieldAttribute.Field) -> AttributedStringTransformerStyle<Date, Self, AttributedStringModifierTransformer<DateFieldInlinePresentationIntentModifier>> {
        modify(inline: inline, for: [field])
    }
}

public extension Date.FormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for fields: Set<AttributeScopes.FoundationAttributes.DateFieldAttribute.Field>) ->
        AttributedStringTransformerStyle<Date, Self.Attributed, AttributedStringModifierTransformer<DateFieldInlinePresentationIntentModifier>>
    {
        attributedStyle.modify(inline: inline, for: fields)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for field: AttributeScopes.FoundationAttributes.DateFieldAttribute.Field) ->
        AttributedStringTransformerStyle<Date, Self.Attributed, AttributedStringModifierTransformer<DateFieldInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [field])
    }
}

#Preview {
    let format = Date.FormatStyle()
        .attributedStyle
        .modify(inline: .emphasized, for: [.year, .minute])

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(context.date, format: format)

            Text(context.date,
                 format: Date.FormatStyle(date: .long, time: .standard)
                     .modify(inline: .stronglyEmphasized, for: [.month, .second])
                     .modify(inline: .strikethrough, for: .day))
        }
    }.font(.title)
}
