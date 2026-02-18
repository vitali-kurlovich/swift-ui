//
//  Created by Vitali Kurlovich on 17.02.26.
//

import SwiftUI

public struct NumberPartForegroundColorModifier: AttributedStringModifier {
    public typealias NumberPart = AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart
    public let numberParts: Set<NumberPart>
    public let color: Color

    public init(numberParts: Set<NumberPart>, color: Color) {
        self.numberParts = numberParts
        self.color = color
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let numberPart = attributes.numberPart else { return }

        if numberParts.contains(numberPart) {
            string.foregroundColor = color
        }
    }
}

public extension AttributedStringModifier {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        MergeAttributedStringModifier<Self, NumberPartForegroundColorModifier>
    {
        let modifier = NumberPartForegroundColorModifier(numberParts: numberParts, color: color)
        return merge(with: modifier)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        MergeAttributedStringModifier<Self, NumberPartForegroundColorModifier>
    {
        modify(color: color, for: [numberPart])
    }
}

public extension FormatStyle where Self.FormatInput: Numeric, Self.FormatOutput == AttributedString {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        let modifier = NumberPartForegroundColorModifier(numberParts: numberParts, color: color)
        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) -> AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>> {
        modify(color: color, for: [numberPart])
    }
}

public extension IntegerFormatStyle {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        attributed.modify(color: color, for: numberParts)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        modify(color: color, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        attributed.modify(color: color, for: numberParts)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        modify(color: color, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle.Currency {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        attributed.modify(color: color, for: numberParts)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        modify(color: color, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle.Percent {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        attributed.modify(color: color, for: numberParts)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        modify(color: color, for: [numberPart])
    }
}

public extension Decimal.FormatStyle {
    @inlinable func modify(color: Color, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        attributed.modify(color: color, for: numberParts)
    }

    @inlinable func modify(color: Color, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartForegroundColorModifier>>
    {
        modify(color: color, for: [numberPart])
    }
}

#Preview {
    let format = IntegerFormatStyle<Int>()
        .attributed
        .modify(color: .red, for: [.integer])

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(Int(context.date.timeIntervalSince1970), format: format)

            Text(context.date.timeIntervalSince1970,
                 format: FloatingPointFormatStyle()
                     .modify(color: .red, for: [.integer])
                     .modify(color: .accentColor, for: [.fraction]))
        }
    }.font(.title)
}
