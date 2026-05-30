//
//  MergeAttributedStringTransformer.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct MergeAttributedStringTransformer<First: AttributedStringTransformer, Second: AttributedStringTransformer>: AttributedStringTransformer {
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
    func merge(with transformer: some AttributedStringTransformer) -> some AttributedStringTransformer {
        MergeAttributedStringTransformer(self, transformer)
    }
}
