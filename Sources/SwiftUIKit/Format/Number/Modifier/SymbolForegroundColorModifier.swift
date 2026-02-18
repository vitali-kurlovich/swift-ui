//
//  SymbolForegroundColorModifier.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 17.02.26.
//

import SwiftUI

public struct SymbolForegroundColorModifier: AttributedStringModifier {
    public typealias Symbol = AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol

    public let symbols: Set<Symbol>
    public let color: Color

    public init(symbols: Set<Symbol>, color: Color) {
        self.symbols = symbols
        self.color = color
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let numberSymbol = attributes.numberSymbol else { return }

        if symbols.contains(numberSymbol) {
            string.foregroundColor = color
        }
    }
}

public extension AttributedStringModifier {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        MergeAttributedStringModifier<Self, SymbolForegroundColorModifier>
    {
        let modifier = SymbolForegroundColorModifier(symbols: symbols, color: color)
        return merge(with: modifier)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        MergeAttributedStringModifier<Self, SymbolForegroundColorModifier>
    {
        modify(color: color, for: [symbol])
    }
}

public extension FormatStyle where Self.FormatInput: Numeric, Self.FormatOutput == AttributedString {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<SymbolForegroundColorModifier>>
    {
        let modifier = SymbolForegroundColorModifier(symbols: symbols, color: color)
        return AttributedStringTransformerStyle(self, transformer: modifier.transformer())
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) -> AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<SymbolForegroundColorModifier>> {
        modify(color: color, for: [symbol])
    }
}

public extension IntegerFormatStyle {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        attributed.modify(color: color, for: symbols)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        modify(color: color, for: [symbol])
    }
}

public extension FloatingPointFormatStyle {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        attributed.modify(color: color, for: symbols)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        modify(color: color, for: [symbol])
    }
}

public extension FloatingPointFormatStyle.Currency {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        attributed.modify(color: color, for: symbols)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        modify(color: color, for: [symbol])
    }
}

public extension FloatingPointFormatStyle.Percent {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        attributed.modify(color: color, for: symbols)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            FloatingPointFormatStyle.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        modify(color: color, for: [symbol])
    }
}

public extension Decimal.FormatStyle {
    @inlinable func modify(color: Color, for symbols: Set<AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol>) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        attributed.modify(color: color, for: symbols)
    }

    @inlinable func modify(color: Color, for symbol: AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol) ->
        AttributedStringTransformerStyle<
            Self.FormatInput,
            Self.Attributed,
            AttributedStringModifierTransformer<SymbolForegroundColorModifier>
        >
    {
        modify(color: color, for: [symbol])
    }
}

#Preview {
    let format = IntegerFormatStyle<Int>()
        .attributed
        .modify(color: .red, for: [.groupingSeparator])

    let currency = FloatingPointFormatStyle<Double>.Currency(code: "USD")

    let percent = FloatingPointFormatStyle<Double>.Percent()

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(Int(context.date.timeIntervalSince1970), format: format)

            Text(context.date.timeIntervalSince1970,
                 format: currency
                     .modify(color: .accentColor, for: [.decimalSeparator, .currency])
                     .modify(color: .orange, for: .percent))

            Text(-context.date.timeIntervalSince1970 / 10000,
                 format: percent
                     .modify(color: .accentColor, for: [.decimalSeparator, .currency])
                     .modify(color: .orange, for: .percent)
                     .modify(color: .green, for: .sign))
                .font(.body.bold())
        }
    }
    .font(.headline.monospaced())
}
