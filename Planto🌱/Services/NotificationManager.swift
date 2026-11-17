import Foundation
import UserNotifications

@MainActor
final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()
    private let reminderHour = 9

    private override init() {
        super.init()
        center.delegate = self
    }

    func requestAuthorization() async {
        _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge])
    }

    func scheduleReminder(for plant: Plant) {
        cancelReminder(for: plant)

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your \(plant.name) 💦"
        content.sound = .default

        let trigger: UNNotificationTrigger
        if plant.wateringFrequency == .everyDay {
            var time = DateComponents()
            time.hour = reminderHour
            trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        } else {
            let seconds = TimeInterval(plant.wateringFrequency.days * 24 * 60 * 60)
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        }

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        center.add(request)
    }

    func cancelReminder(for plant: Plant) {
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }

    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
}
