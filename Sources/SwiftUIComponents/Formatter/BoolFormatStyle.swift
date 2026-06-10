//
//  Created by Kurlovich Vitali on 6/10/26.
//

import Foundation

public struct BoolFormatStyle: FormatStyle {
    public typealias FormatInput = Bool
    public typealias FormatOutput = String

    public func format(_ value: Bool) -> String {
        if value {
            "Yes"
        } else {
            "No"
        }
    }
}

public extension FormatStyle where Self == BoolFormatStyle, Self.FormatInput == Bool, Self.FormatOutput == String {
    static var boolean: BoolFormatStyle {
        BoolFormatStyle()
    }
}

public extension Bool {
    func formatted<S: FormatStyle>(_ format: S) -> S.FormatOutput where Bool == S.FormatInput {
        format.format(self)
    }

    func formatted() -> String {
        formatted(.boolean)
    }
}
