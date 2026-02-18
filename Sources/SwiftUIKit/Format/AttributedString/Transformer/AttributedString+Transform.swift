//
//  AttributedString+Transform.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 18.02.26.
//

import Foundation

public extension AttributedString {
    func transform<T: AttributedStringTransformer>(_ transformer: T) -> AttributedString {
        transformer.transform(self)
    }

    func transform<T: AttributedStringModifier>(_ modifier: T) -> AttributedString {
        modifier.transformer().transform(self)
    }
}
