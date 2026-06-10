//
//  Created by Kurlovich Vitali on 6/10/26.
//

import SwiftUI

public struct LabeledValueList: View {
    let labels: [LabeledValue]

    public init(labels: [LabeledValue]) {
        self.labels = labels
    }

    public var body: some View {
        #if os(macOS)
            Table(of: LabeledValue.self, columns: {
                TableColumn("Name") { label in
                    if label.systemImage.isEmpty {
                        Text(label.titleKey)
                    } else {
                        Label(label.titleKey, systemImage: label.systemImage)
                    }
                }
                TableColumn("Value") { label in
                    if label.isGroup == false {
                        LabeledValueContent(label: label)
                    }
                }

            }, rows: {
                GroupOfPeopleRows(labels: labels)
            })
        #else
            List {
                OutlineGroup(labels, children: \.childs) { label in
                    LabeledValueContent(label: label)
                }
            }
        #endif
    }
}

private struct GroupOfPeopleRows: TableRowContent {
    let labels: [LabeledValue]

    var tableRowBody: some TableRowContent<LabeledValue> {
        ForEach(labels) { label in
            if label.childs?.isEmpty ?? true {
                TableRow(label)
            } else {
                DisclosureTableRow(label) {
                    GroupOfPeopleRows(labels: label.childs ?? [])
                }
            }
        }
    }
}

#Preview {
    LabeledValueList(labels: LabeledValue.moc)
}

private extension LabeledValue {
    static var moc: [LabeledValue] {
        let builder = LabeledValueBuilder()

        builder
            .append("First", value: true, format: .boolean, systemImage: "lightbulb.led")
            .append("Second", value: "2")
            .appendGroup("Group", systemImage: "photo.on.rectangle.angled")
            .append("Title 3", value: "3")
            .append("Title 4", value: "4", systemImage: "circle.dotted.and.circle")
            .appendGroup("SubGroup", systemImage: "camera")
            .append("Title 5", value: "5", systemImage: "circle.dotted.and.circle")
            .commitGroup()
            .append("Title 6", value: "6")
            .append("Title 7", value: "7")
            .commitGroup()
            .append("Title 8", value: "8", systemImage: "camera")

        return builder.build()
    }
}
