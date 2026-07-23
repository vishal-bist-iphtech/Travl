//
//  NotificationViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import Foundation
import SwiftUI
import Combine

final class NotificationViewModel: ObservableObject {
    
    @Published var notifications: [AppNotification] = []
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    func markAsRead(_ notification: AppNotification) {
        
        guard let index = notifications.firstIndex(where: {
            $0.id == notification.id
        }) else { return }
        
        notifications[index].isRead = true
    }
    
    func markAllAsRead() {
        
        for index in notifications.indices {
            notifications[index].isRead = true
        }
    }
}
