//
//  AttributedString+Transform.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 18.02.26.
//

import Foundation

public extension AttributedString {
    func transform(_ transformer: some AttributedStringTransformer) -> AttributedString {
        transformer.transform(self)
    }

    func transform(_ modifier: some AttributedStringModifier) -> AttributedString {
        modifier.transformer().transform(self)
    }
}
