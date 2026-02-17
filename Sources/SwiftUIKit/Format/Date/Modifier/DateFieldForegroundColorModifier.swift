//
//  Created by Vitali Kurlovich on 17.02.26.
//

import SwiftUI

public struct DateFieldForegroundColorModifier: AttributedStringModifier {
    public typealias Field = AttributeScopes.FoundationAttributes.DateFieldAttribute.Field
    public let fields: Set<Field>
    public let color: Color

    public init(fields: Set<Field>, color: Color) {
        self.fields = fields
        self.color = color
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let field = attributes.foundation.dateField else { return }

        if fields.contains(field) {
            string.foregroundColor = color
        }
    }
}

public extension FormatStyle where Self.FormatInput == Date, Self.FormatOutput == AttributedString {
    @inlinable func modify(color: Color, for fields: Set<AttributeScopes.FoundationAttributes.DateFieldAttribute.Field>) ->

        AttributedStringTransformerStyle<Date, Self, AttributedStringModifierTransformer<DateFieldForegroundColorModifier>>

    {
        let modifier = DateFieldForegroundColorModifier(fields: fields, color: color)

        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(color: Color, for field: AttributeScopes.FoundationAttributes.DateFieldAttribute.Field) -> AttributedStringTransformerStyle<Date, Self, AttributedStringModifierTransformer<DateFieldForegroundColorModifier>> {
        modify(color: color, for: [field])
    }
}

public extension Date.FormatStyle {
    @inlinable func modify(color: Color, for fields: Set<AttributeScopes.FoundationAttributes.DateFieldAttribute.Field>) ->

        AttributedStringTransformerStyle<Date, Self.Attributed, AttributedStringModifierTransformer<DateFieldForegroundColorModifier>>
    {
        attributedStyle.modify(color: color, for: fields)
    }

    @inlinable func modify(color: Color, for field: AttributeScopes.FoundationAttributes.DateFieldAttribute.Field) ->

        AttributedStringTransformerStyle<Date, Self.Attributed, AttributedStringModifierTransformer<DateFieldForegroundColorModifier>>
    {
        modify(color: color, for: [field])
    }
}

#Preview {
    let format = Date.FormatStyle()
        .attributedStyle
        .modify(color: .red, for: [.year, .minute])
        .modify(color: .accentColor, for: .hour)

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(context.date, format: format)

            Text(context.date,
                 format: Date.FormatStyle(date: .long, time: .standard)
                     .modify(color: .red, for: [.month, .second])
                     .modify(color: .blue, for: .day))
        }
    }.font(.title)
}
