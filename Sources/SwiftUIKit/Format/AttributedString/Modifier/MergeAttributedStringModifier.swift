//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct MergeAttributedStringModifier<First, Second>: AttributedStringModifier
    where
    First: AttributedStringModifier, Second: AttributedStringModifier
{
    public let first: First
    public let second: Second

    public init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        first.modify(attributes: attributes, &string)
        second.modify(attributes: attributes, &string)
    }
}

public extension AttributedStringModifier {
    func merge<M: AttributedStringModifier>(with modifier: M) -> MergeAttributedStringModifier<Self, M> {
        MergeAttributedStringModifier(self, modifier)
    }
}
