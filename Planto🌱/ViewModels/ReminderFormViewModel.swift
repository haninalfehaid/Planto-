import Foundation
import Observation

@MainActor
@Observable
final class ReminderFormViewModel {
    var name: String
    var room: Room
    var light: LightCondition
    var wateringFrequency: WateringFrequency
    var waterAmount: WaterAmount

    private let editingPlant: Plant?

    init(plant: Plant? = nil) {
        editingPlant = plant
        name = plant?.name ?? ""
        room = plant?.room ?? .bedroom
        light = plant?.light ?? .fullSun
        wateringFrequency = plant?.wateringFrequency ?? .everyDay
        waterAmount = plant?.waterAmount ?? .ml20to50
    }

    var isEditing: Bool { editingPlant != nil }

    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var plantToDelete: Plant? { editingPlant }

    func buildPlant() -> Plant {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if var plant = editingPlant {
            plant.name = cleanName
            plant.room = room
            plant.light = light
            plant.wateringFrequency = wateringFrequency
            plant.waterAmount = waterAmount
            return plant
        }

        return Plant(
            name: cleanName,
            room: room,
            light: light,
            wateringFrequency: wateringFrequency,
            waterAmount: waterAmount
        )
    }
}
