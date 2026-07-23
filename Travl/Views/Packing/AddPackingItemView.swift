//
//  AddPackingItemView.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI
import CoreData

struct AddPackingItemView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var packingViewModel: PackingViewModel

    let trip: TripEntity?

    @State private var title = ""
    @State private var category = "Clothes"
    @State private var quantity = "1"
    @State private var notes = ""

    var body: some View {

        NavigationStack {
            Form {
                PackingForm(
                    title: $title,
                    category: $category,
                    quantity: $quantity,
                    notes: $notes
                )
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {

                        packingViewModel.addPackingItem(
                            title: title,
                            category: category,
                            quantity: Int(quantity) ?? 1,
                            notes: notes,
                            trip: trip
                        )

                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)

    trip.title = "Goa Trip"

    return AddPackingItemView(trip: trip)
        .environmentObject(PackingViewModel())
}
