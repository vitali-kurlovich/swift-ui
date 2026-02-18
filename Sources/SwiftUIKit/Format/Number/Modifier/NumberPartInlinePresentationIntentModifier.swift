//
//  Created by Vitali Kurlovich on 18.02.26.
//

import SwiftUI

public struct NumberPartInlinePresentationIntentModifier: AttributedStringModifier {
    public typealias NumberPart = AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart
    public let numberParts: Set<NumberPart>
    public let inline: InlinePresentationIntent

    public init(numberParts: Set<NumberPart>, inline: InlinePresentationIntent) {
        self.numberParts = numberParts
        self.inline = inline
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let numberPart = attributes.numberPart else { return }

        if numberParts.contains(numberPart) {
            string.inlinePresentationIntent = inline
        }
    }
}

public extension AttributedStringModifier {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        MergeAttributedStringModifier<Self, NumberPartInlinePresentationIntentModifier>
    {
        let modifier = NumberPartInlinePresentationIntentModifier(numberParts: numberParts, inline: inline)
        return merge(with: modifier)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        MergeAttributedStringModifier<Self, NumberPartInlinePresentationIntentModifier>
    {
        modify(inline: inline, for: [numberPart])
    }
}

public extension FormatStyle where Self.FormatInput: Numeric, Self.FormatOutput == AttributedString {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self,
            AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>
        >
    {
        let modifier = NumberPartInlinePresentationIntentModifier(numberParts: numberParts, inline: inline)
        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) -> AttributedStringTransformerStyle<
        Self.FormatInput,
        Self,
        AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>
    > {
        modify(inline: inline, for: [numberPart])
    }
}

public extension IntegerFormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        attributed.modify(inline: inline, for: numberParts)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        attributed.modify(inline: inline, for: numberParts)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle.Currency {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        attributed.modify(inline: inline, for: numberParts)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [numberPart])
    }
}

public extension FloatingPointFormatStyle.Percent {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        attributed.modify(inline: inline, for: numberParts)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, FloatingPointFormatStyle.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [numberPart])
    }
}

public extension Decimal.FormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for numberParts: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        attributed.modify(inline: inline, for: numberParts)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for numberPart: AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self.Attributed, AttributedStringModifierTransformer<NumberPartInlinePresentationIntentModifier>>
    {
        modify(inline: inline, for: [numberPart])
    }
}

#Preview {
    let format = IntegerFormatStyle<Int>()
        .attributed
        .modify(inline: .emphasized, for: [.integer])

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(Int(context.date.timeIntervalSince1970), format: format)

            Text(context.date.timeIntervalSince1970,
                 format: FloatingPointFormatStyle()
                     .modify(inline: [.stronglyEmphasized], for: [.integer])
                     .modify(inline: [.strikethrough, .emphasized], for: [.fraction]))
        }
    }.font(.title)
}
