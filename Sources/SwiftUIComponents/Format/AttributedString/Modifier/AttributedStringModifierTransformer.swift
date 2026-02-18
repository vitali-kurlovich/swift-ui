//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct AttributedStringModifierTransformer<M: AttributedStringModifier>: AttributedStringTransformer {
    public let modifier: M

    public init(_ modifier: M) {
        self.modifier = modifier
    }

    public func transform(_ string: AttributedString) -> AttributedString {
        var attributedString = string

        for run in attributedString.runs {
            modifier.modify(attributes: run.attributes, &attributedString[run.range])
        }

        return attributedString
    }
}

public extension AttributedStringTransformer {
    func merge<M: AttributedStringModifier>(with modifier: M) -> AttributedStringModifierTransformer<M> {
        AttributedStringModifierTransformer(modifier)
    }
}

public extension AttributedStringModifier {
    func transformer() -> AttributedStringModifierTransformer<Self> {
        AttributedStringModifierTransformer(self)
    }
}
