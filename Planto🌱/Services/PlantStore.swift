import Foundation

struct PlantStore {
    private let key = "saved_plants"
    private let defaults = UserDefaults.standard

    func load() -> [Plant] {
        guard let data = defaults.data(forKey: key),
              let plants = try? JSONDecoder().decode([Plant].self, from: data)
        else { return [] }
        return plants
    }

    func save(_ plants: [Plant]) {
        guard let data = try? JSONEncoder().encode(plants) else { return }
        defaults.set(data, forKey: key)
    }
}
