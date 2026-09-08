# swift-ui

Collection of SwiftUI components and useful utilities

## Modules

 - VisualEffects - Useful abstractions and components for integrating Metal shaders into SwiftUI apps.

 - SwiftUIComponents - Utilities and UI components


### Examples:

---

```swift
@State
    var side: Side = .front

    HStack {
        DoubleSide($side, front: {
            PreviewContent(color: .green, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .red, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })

        DoubleSide($side, reversed: true, front: {
            PreviewContent(color: .purple, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .mint, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })

        DoubleSide($side,
                   axis: (x: 1, y: 0, z: 0),
                   front: {
                       PreviewContent(color: .green, systemName: "moon.stars.fill")
                   }, back: {
                       PreviewContent(color: .red, systemName: "cloud.moon.fill")
                           .scaleEffect(y: -1)

                   })

        DoubleSide($side, anchor: .trailing, front: {
            PreviewContent(color: .purple, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .mint, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })
    }
    Button("Toggle") {
        withAnimation {
            side.toggle()
        }
    }
```

https://github.com/user-attachments/assets/b9569e8a-ffcd-46f7-946b-ee7d6104b381

---

```swift
let colorModifier = DateFieldForegroundColorModifier(fields: [.year], color: .accentColor)
        .modify(color: .pink, for: .second)
        .modify(inline: .stronglyEmphasized, for: [.year, .minute])

    TimelineView(.periodic(from: .now, by: 1)) { context in
        Form {
            Text(context.date)

            Text(context.date, date: .abbreviated, time: .standard)

            Text(context.date, date: .abbreviated, time: .standard, transform: colorModifier)
        }.font(.title)
            .safeAreaPadding()
        
    }
```

<img width="270" height="103"  src="https://github.com/user-attachments/assets/3f1f24f1-7b18-47f1-8b6b-16a626121ca9" />

---

```swift
    Checkerboard(.small())
    Checkerboard(.medium())
    Checkerboard(.large())
```
<img width="617" height="412" alt="Screenshot 2026-08-18 at 18 11 47" src="https://github.com/user-attachments/assets/098b606c-27e1-439a-b7c1-e492256b50d2" />


