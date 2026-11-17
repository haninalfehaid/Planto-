import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let onToggle: () -> Void
    let onEdit: () -> Void

    private var isDone: Bool { plant.isWateredToday }

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isDone ? Color.plantGreen : .secondary)
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                Label("in \(plant.room.title)", systemImage: "location")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(plant.name)
                    .font(.title2)
                    .foregroundStyle(isDone ? .secondary : .primary)

                HStack(spacing: 8) {
                    TagView(icon: plant.light.icon, text: plant.light.title, color: .sunYellow)
                    TagView(icon: "drop", text: plant.waterAmount.title, color: .waterBlue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture(perform: onEdit)
        }
        .padding(.vertical, 8)
        .opacity(isDone ? 0.6 : 1)
    }
}

#Preview {
    PlantRowView(plant: Plant(name: "Monstera", room: .kitchen), onToggle: {}, onEdit: {})
        .padding()
        .preferredColorScheme(.dark)
}
