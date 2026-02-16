//
//  AttributedStringTransformer.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 14.02.26.
//

import Foundation

public protocol AttributedStringTransformer: Codable, Hashable {
    func transform(_ string: AttributedString) -> AttributedString
}
