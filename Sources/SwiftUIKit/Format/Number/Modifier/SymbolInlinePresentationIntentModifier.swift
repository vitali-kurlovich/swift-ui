//
//  Created by Vitali Kurlovich on 18.02.26.
//

import SwiftUI

public struct SymbolInlinePresentationIntentModifier: AttributedStringModifier {
    public typealias Symbol = AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol

    public let symbols: Set<Symbol>
    public let inline: InlinePresentationIntent

    public init(symbols: Set<Symbol>, inline: InlinePresentationIntent) {
        self.symbols = symbols
        self.inline = inline
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let numberSymbol = attributes.numberSymbol else { return }

        if symbols.contains(numberSymbol) {
            string.inlinePresentationIntent = inline
        }
    }
}

public extension AttributedStringModifier {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        MergeAttributedStringModifier<Self, SymbolInlinePresentationIntentModifier>
    {
        let modifier = SymbolInlinePresentationIntentModifier(symbols: symbols, inline: inline)
        return merge(with: modifier)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        MergeAttributedStringModifier<Self, SymbolInlinePresentationIntentModifier>
    {
        modify(inline: inline, for: [symbol])
    }
}

public extension FormatStyle where Self.FormatInput: Numeric, Self.FormatOutput == AttributedString {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>>
    {
        let modifier = SymbolInlinePresentationIntentModifier(symbols: symbols, inline: inline)
        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) -> AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>> {
        modify(inline: inline, for: [symbol])
    }
}

public extension IntegerFormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        attributed.modify(inline: inline, for: symbols)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        modify(inline: inline, for: [symbol])
    }
}

public extension FloatingPointFormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        attributed.modify(inline: inline, for: symbols)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        modify(inline: inline, for: [symbol])
    }
}

public extension FloatingPointFormatStyle.Currency {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        attributed.modify(inline: inline, for: symbols)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        modify(inline: inline, for: [symbol])
    }
}

public extension FloatingPointFormatStyle.Percent {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        attributed.modify(inline: inline, for: symbols)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        modify(inline: inline, for: [symbol])
    }
}

public extension Decimal.FormatStyle {
    @inlinable func modify(inline: InlinePresentationIntent, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        attributed.modify(inline: inline, for: symbols)
    }

    @inlinable func modify(inline: InlinePresentationIntent, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolInlinePresentationIntentModifier>
        >
    {
        modify(inline: inline, for: [symbol])
    }
}

#Preview {
    let format = IntegerFormatStyle<Int>()
        .attributed
        .modify(inline: .emphasized, for: [.groupingSeparator])

    let currency = FloatingPointFormatStyle<Double>.Currency(code: "USD")

    let percent = FloatingPointFormatStyle<Double>.Percent()

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(Int(context.date.timeIntervalSince1970), format: format)

            Text(context.date.timeIntervalSince1970,
                 format: currency
                     .modify(inline: [.stronglyEmphasized], for: [.decimalSeparator, .currency]))

            Text(-context.date.timeIntervalSince1970 / 10000,
                 format: percent
                     .modify(inline: [.stronglyEmphasized], for: [.decimalSeparator, .currency])
                     .modify(inline: .strikethrough, for: .percent)
                     .modify(inline: .stronglyEmphasized, for: .sign))
        }
    }
    .font(.title)
}
