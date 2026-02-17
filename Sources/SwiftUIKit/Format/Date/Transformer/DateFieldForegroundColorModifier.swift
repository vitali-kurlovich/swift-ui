//
//  Created by Vitali Kurlovich on 17.02.26.
//

import SwiftUI

public struct DateFieldForegroundColorModifier: AttributedStringModifier {
    public typealias Field = AttributeScopes.FoundationAttributes.DateFieldAttribute.Field
    public let fields: Set<Field>
    public let color: Color

    public init(fields: Set<Field>, color: Color) {
        self.fields = fields
        self.color = color
    }

    public func modify(attributes: AttributeContainer, _ string: inout AttributedSubstring) {
        guard let field = attributes.foundation.dateField else { return }

        if fields.contains(field) {
            string.foregroundColor = color
        }
    }
}
