//
//  Created by Vitali Kurlovich on 16.02.26.
//

import Foundation

public protocol AttributedStringModifier: Codable, Hashable {
    func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring)
}
