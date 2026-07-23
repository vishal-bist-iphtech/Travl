//
//  AppNotification.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import Foundation

struct AppNotification: Identifiable {
    
    let id = UUID()
    let title: String
    let message: String
    let systemImage: String
    let date: Date
    var isRead: Bool = false
    
}
