//
// Created by Vendly on 10/11/22.
//

import Foundation
import UIKit

@propertyWrapper
struct NotificationData {

    let key: String
    let wrappedValue: NotificationValue

}

struct NotificationValue {

    let title: String
    let desc: String

    var notificationContent: UNNotificationContent { get {
        let content = UNMutableNotificationContent()
        content.badge   = 1
        content.title   = title
        content.body    = desc
        content.sound   = .default
        return content
    }}
}

class LocalNotification {

    static var shared: LocalNotification = .init()

    @NotificationData(key: "MORNING_KEY_NOTIFICATION", wrappedValue: .init(title: "WAKE UP!", desc: "Open your eyes, wash your face, apply your skincare 😶‍🌫"))
    var morningRoutineNotif

    @NotificationData(key: "NIGHT_KEY_NOTIFICATION", wrappedValue: .init(title: "NIGHT TIME!", desc: "Are you going to bed? Apply your skincare before you sleep 😘"))
    var nightRoutineNotif

    func requestDailyMorningRoutine(hour: Int, minute: Int)
    {
        requestDailyNotificationRoutine(
            hour: hour,
            minute: minute,
            identifier: _morningRoutineNotif.key,
            content: morningRoutineNotif.notificationContent
        )
    }

    func requestDailyNightRoutine(hour: Int, minute: Int)
    {
        requestDailyNotificationRoutine(
            hour: hour,
            minute: minute,
            identifier: _nightRoutineNotif.key,
            content: nightRoutineNotif.notificationContent
        )
    }

    private func requestDailyNotificationRoutine(hour: Int, minute: Int, identifier: String, content: UNNotificationContent)
    {
        let dateComponents: DateComponents = {
            var components      = DateComponents(calendar: Calendar.current)
            components.hour     = hour
            components.minute   = minute
            return components
        }()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

}
