//
//  MergeAttributedStringTransformer.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct MergeAttributedStringTransformer<First, Second>: AttributedStringTransformer where
    First: AttributedStringTransformer, Second: AttributedStringTransformer
{
    public let first: First
    public let second: Second

    public init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }

    public func transform(_ string: AttributedString) -> AttributedString {
        second.transform(first.transform(string))
    }
}

public extension AttributedStringTransformer {
    func merge<T: AttributedStringTransformer>(with transformer: T) -> some AttributedStringTransformer {
        MergeAttributedStringTransformer(self, transformer)
    }
}
