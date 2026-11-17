import Foundation

protocol PlantOption: CaseIterable, Identifiable, Hashable, Codable
where AllCases: RandomAccessCollection {
    var title: String { get }
}

extension PlantOption where Self: RawRepresentable, RawValue == String {
    var id: String { rawValue }
    var title: String { rawValue }
}

enum Room: String, PlantOption {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum LightCondition: String, PlantOption {
    case fullSun = "Full sun"
    case partialSun = "Partial sun"
    case lowLight = "Low light"

    var icon: String {
        switch self {
        case .fullSun: "sun.max"
        case .partialSun: "cloud.sun"
        case .lowLight: "moon"
        }
    }
}

enum WateringFrequency: String, PlantOption {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"

    var days: Int {
        switch self {
        case .everyDay: 1
        case .every2Days: 2
        case .every3Days: 3
        case .onceAWeek: 7
        case .every10Days: 10
        case .every2Weeks: 14
        }
    }
}

enum WaterAmount: String, PlantOption {
    case ml20to50 = "20-50 ml"
    case ml50to100 = "50-100 ml"
    case ml100to200 = "100-200 ml"
    case ml200to300 = "200-300 ml"
}

struct Plant: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var room: Room
    var light: LightCondition
    var wateringFrequency: WateringFrequency
    var waterAmount: WaterAmount

    var lastWateredDate: Date?

    init(
        id: UUID = UUID(),
        name: String,
        room: Room = .bedroom,
        light: LightCondition = .fullSun,
        wateringFrequency: WateringFrequency = .everyDay,
        waterAmount: WaterAmount = .ml20to50,
        lastWateredDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.wateringFrequency = wateringFrequency
        self.waterAmount = waterAmount
        self.lastWateredDate = lastWateredDate
    }

    var isWateredToday: Bool {
        guard let lastWateredDate else { return false }
        return Calendar.current.isDateInToday(lastWateredDate)
    }
}
