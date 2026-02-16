//
//  MergeAttributedStringUpdater.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct MergeAttributedStringUpdater<First, Second>: AttributedStringUpdater
    where
    First: AttributedStringUpdater, Second: AttributedStringUpdater
{
    public let first: First
    public let second: Second

    public init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }

    public func update(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        first.update(attributes: attributes, &string)
        second.update(attributes: attributes, &string)
    }
}

public extension AttributedStringUpdater {
    func merge<U: AttributedStringUpdater>(with updater: U) -> some AttributedStringUpdater {
        MergeAttributedStringUpdater(self, updater)
    }
}
