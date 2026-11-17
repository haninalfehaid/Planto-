import SwiftUI

struct OptionPickerRow<Option: PlantOption>: View {
    let title: String
    let icon: String
    @Binding var selection: Option

    var body: some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(Option.allCases) { option in
                    Text(option.title).tag(option)
                }
            }
            .pickerStyle(.menu)
            .tint(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}
