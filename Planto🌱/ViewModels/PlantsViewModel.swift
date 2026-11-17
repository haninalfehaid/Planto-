import Foundation
import Observation

enum ReminderSheet: Identifiable {
    case add
    case edit(Plant)

    var id: String {
        switch self {
        case .add: "add"
        case .edit(let plant): plant.id.uuidString
        }
    }

    var plant: Plant? {
        if case .edit(let plant) = self { return plant }
        return nil
    }
}

@MainActor
@Observable
final class PlantsViewModel {
    private(set) var plants: [Plant] = []
    var activeSheet: ReminderSheet?

    private let store = PlantStore()
    private let notifications = NotificationManager.shared

    init() {
        plants = store.load()
    }

    var hasPlants: Bool { !plants.isEmpty }

    var completedCount: Int {
        plants.filter(\.isWateredToday).count
    }

    var progress: Double {
        guard hasPlants else { return 0 }
        return Double(completedCount) / Double(plants.count)
    }

    var allDone: Bool {
        hasPlants && completedCount == plants.count
    }

    var progressMessage: String {
        completedCount == 0
            ? "Your plants are waiting for a sip 💦"
            : "\(completedCount) of your plants feel loved today ✨"
    }

    func startAdding() {
        activeSheet = .add
    }

    func startEditing(_ plant: Plant) {
        activeSheet = .edit(plant)
    }

    func save(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
        } else {
            plants.append(plant)
        }
        persist()
        notifications.scheduleReminder(for: plant)
    }

    func delete(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        notifications.cancelReminder(for: plant)
        persist()
    }

    func toggleWatered(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].lastWateredDate = plants[index].isWateredToday ? nil : .now
        persist()
    }

    func requestNotificationPermission() async {
        await notifications.requestAuthorization()
    }

    private func persist() {
        store.save(plants)
    }
}
