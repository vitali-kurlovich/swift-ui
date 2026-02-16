//
//  AttributedStringTransformer.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 14.02.26.
//

import Foundation

public protocol AttributedStringTransformer: Codable, Hashable {
    func transform(_ string: AttributedString) -> AttributedString

    func transform(attributes: AttributeContainer, _ string: inout AttributedSubstring)
}

public extension AttributedStringTransformer {
    func transform(_ string: AttributedString) -> AttributedString {
        var attributedString = string

        for run in attributedString.runs {
            transform(attributes: run.attributes, &attributedString[run.range])
        }

        return attributedString
    }

    func transform(attributes _: AttributeContainer, _: inout AttributedSubstring) {}
}
