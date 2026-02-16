//
//  AttributedStringUpdateTransformer.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public struct AttributedStringUpdateTransformer<U: AttributedStringUpdater>: AttributedStringTransformer {
    public let updater: U

    public init(_ updater: U) {
        self.updater = updater
    }

    public func transform(_ string: AttributedString) -> AttributedString {
        var attributedString = string

        for run in attributedString.runs {
            updater.update(attributes: run.attributes, &attributedString[run.range])
        }

        return attributedString
    }
}

public extension AttributedStringTransformer {
    func merge<U: AttributedStringUpdater>(with updater: U) -> some AttributedStringTransformer {
        AttributedStringUpdateTransformer(updater)
    }
}

public extension AttributedStringUpdater {
    func transformer() -> AttributedStringUpdateTransformer<Self> {
        AttributedStringUpdateTransformer(self)
    }
}
