//
//  ToDoAlertNotifier.swift
//  Dunnit
//
//  Created by Andrew on 16/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UserNotifications

class ToDoAlertNotifier {
    
    func requestNotificationsPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge])
        { (granted, error) in }
    }
    
    func createAlert(title: String, body: String, reminderDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.day = Calendar.current.component(.day, from: reminderDate)
        dateComponents.hour = Calendar.current.component(.hour, from: reminderDate)
        dateComponents.minute = Calendar.current.component(.minute, from: reminderDate)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error { print(error) }
        }
    }
}
