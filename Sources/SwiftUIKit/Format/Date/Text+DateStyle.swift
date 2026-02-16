//
//  Created by Vitali Kurlovich on 15.02.26.
//

import SwiftUI

public extension Text {
    init(_ input: Date) {
        self.init(input, format: .dateTime)
    }

    init(_ input: Date, date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) {
        self.init(input, format: Date.FormatStyle(date: date, time: time))
    }
}

public extension Text {
    @inlinable init<T>(_ input: Date, format: Date.FormatStyle, transform: T) where T: AttributedStringUpdater {
        self.init(input, format: format.attributedStyle, transform: transform)
    }

    @inlinable init<T>(_ input: Date, date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle, transform: T) where T: AttributedStringUpdater {
        self.init(input, format: Date.FormatStyle(date: date, time: time), transform: transform)
    }
}

#Preview {
    let fontUpdater = DateFieldInlinePresentationIntentUpdater(fields: [.year, .minute], inline: [.stronglyEmphasized])

    let colorUpdater = DateFieldForegroundColorUpdater([
        .year: .accentColor,
        .second: .pink,
    ])

    let transform = fontUpdater.merge(with: colorUpdater)

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(context.date)

            Text(context.date, date: .abbreviated, time: .standard)

            Text(context.date, date: .abbreviated, time: .standard, transform: transform)
        }.font(.title)
    }
}
