//
//  ExpenseCategory.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//
import SwiftUI

struct ExpenseCategory: Identifiable {

    let id = UUID()

    let name: String

    let amount: Double

    let color: Color
}
