//
//  Created by Vitali Kurlovich on 15.02.26.
//

import SwiftUI

public struct AttributedStringTransformerStyle<FormatInput,
    BaseFormatStyle: FormatStyle,
    Transformer: AttributedStringTransformer>: FormatStyle
    where
    BaseFormatStyle.FormatInput == FormatInput,
    BaseFormatStyle.FormatOutput == AttributedString
{
    public typealias FormatOutput = AttributedString

    public var base: BaseFormatStyle
    public var transformer: Transformer

    @inlinable public init(_ base: BaseFormatStyle, transformer: Transformer) {
        self.base = base
        self.transformer = transformer
    }

    public func format(_ value: FormatInput) -> AttributedString {
        let attrString = base.format(value)
        return transformer.transform(attrString)
    }
}

public extension FormatStyle where Self.FormatOutput == AttributedString {
    @inlinable func transform<Transformer: AttributedStringTransformer>(_ transformer: Transformer) -> AttributedStringTransformerStyle<Self.FormatInput, Self, Transformer> {
        AttributedStringTransformerStyle(self, transformer: transformer)
    }
}

public extension FormatStyle where Self.FormatOutput == AttributedString {
    @inlinable func transform<Updater: AttributedStringModifier>(_ updater: Updater) -> AttributedStringTransformerStyle<Self.FormatInput, Self, AttributedStringModifierTransformer<Updater>> {
        AttributedStringTransformerStyle(self, transformer: updater.transformer())
    }
}

public extension Text {
    @inlinable init<F, T>(_ input: F.FormatInput, format: F, transform: T) where F: FormatStyle, F.FormatInput: Equatable, F.FormatOutput == AttributedString, T: AttributedStringTransformer {
        self.init(input, format: format.transform(transform))
    }

    @inlinable init<F, M>(_ input: F.FormatInput, format: F, transform: M) where F: FormatStyle, F.FormatInput: Equatable, F.FormatOutput == AttributedString, M: AttributedStringModifier {
        self.init(input, format: format.transform(transform))
    }
}
