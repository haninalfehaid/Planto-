import SwiftUI

struct SetReminderView: View {
    @State private var form: ReminderFormViewModel
    @Environment(\.dismiss) private var dismiss

    let onSave: (Plant) -> Void
    let onDelete: (Plant) -> Void

    init(plant: Plant?,
         onSave: @escaping (Plant) -> Void,
         onDelete: @escaping (Plant) -> Void) {
        _form = State(initialValue: ReminderFormViewModel(plant: plant))
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    nameField

                    fieldGroup {
                        OptionPickerRow(title: "Room", icon: "location", selection: $form.room)
                        Divider().padding(.horizontal)
                        OptionPickerRow(title: "Light", icon: "sun.max", selection: $form.light)
                    }

                    fieldGroup {
                        OptionPickerRow(title: "Watering Days", icon: "drop",
                                        selection: $form.wateringFrequency)
                        Divider().padding(.horizontal)
                        OptionPickerRow(title: "Water", icon: "drop", selection: $form.waterAmount)
                    }

                    if form.isEditing {
                        deleteButton
                    }
                }
                .padding()
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        guard form.canSave else { return }
                        onSave(form.buildPlant())
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.plantGreen)
                }
            }
        }
    }

    private var nameField: some View {
        HStack {
            Text("Plant Name")
            TextField("Pothos", text: $form.name)
                .textInputAutocapitalization(.words)
        }
        .padding()
        .background(Color.fieldBackground, in: Capsule())
    }

    private func fieldGroup<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0, content: content)
            .padding(.vertical, 6)
            .background(Color.fieldBackground, in: RoundedRectangle(cornerRadius: 24))
    }

    private var deleteButton: some View {
        Button(role: .destructive) {
            if let plant = form.plantToDelete {
                onDelete(plant)
            }
            dismiss()
        } label: {
            Text("Delete Reminder")
                .frame(maxWidth: .infinity)
                .padding()
        }
        .foregroundStyle(.red)
        .background(Color.fieldBackground, in: Capsule())
    }
}

#Preview("Add") {
    SetReminderView(plant: nil, onSave: { _ in }, onDelete: { _ in })
        .preferredColorScheme(.dark)
}

#Preview("Edit") {
    SetReminderView(plant: Plant(name: "Pothos"), onSave: { _ in }, onDelete: { _ in })
        .preferredColorScheme(.dark)
}
