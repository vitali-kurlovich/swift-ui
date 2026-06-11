//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public extension Gradient {
    func interpolated(at position: CGFloat, in colorSpace: Gradient.ColorSpace = .perceptual) -> Color {
        var iterator = stops.makeIterator()

        guard var last = iterator.next() else {
            return .clear
        }

        while last.location <= position {
            guard let stop = iterator.next() else {
                return last.color
            }

            if stop.location >= position {
                return color(at: position, last: last, next: stop, in: colorSpace)
            }

            last = stop
        }

        return last.color
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension Gradient {
    func containsTransparent(_ environment: EnvironmentValues) -> Bool {
        stops.contains {
            $0.color.resolve(in: environment).opacity < 1.0
        }
    }
}

private extension Gradient {
    @available(iOS 18.0, macOS 15.0, *)
    func color(at position: CGFloat, last: Stop, next: Stop, in colorSpace: Gradient.ColorSpace) -> Color {
        if last.location == next.location {
            if position <= last.location {
                return last.color
            } else {
                return next.color
            }
        }

        let distance = next.location - last.location
        let offset = position - last.location

        var fraction = offset / distance

        fraction = max(0, fraction)
        fraction = min(1, fraction)

        return last.color.mix(with: next.color, by: fraction, in: colorSpace)
    }
}

@available(iOS 18.0, macOS 15.0, *)
#Preview {
    let gradient = Gradient(colors: [.red, .yellow])

    gradient.interpolated(at: 0)
    gradient.interpolated(at: 0.5)
    gradient.interpolated(at: 1)
}
