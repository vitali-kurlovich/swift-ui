//
//  AttributedStringUpdater.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public protocol AttributedStringUpdater: Codable, Hashable {
    func update(attributes: AttributeContainer, _ string: inout AttributedSubstring)
}
