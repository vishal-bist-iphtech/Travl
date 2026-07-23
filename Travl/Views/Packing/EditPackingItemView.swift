//
//  EditPackingItemView.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI
import CoreData

struct EditPackingItemView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var packingViewModel: PackingViewModel

    let item: PackingItemEntity

    @State private var title: String
    @State private var category: String
    @State private var quantity: String
    @State private var notes: String
    @State private var isPacked: Bool

    init(item: PackingItemEntity) {

        self.item = item

        _title = State(initialValue: item.title ?? "")
        _category = State(initialValue: item.category ?? "Clothes")
        _quantity = State(initialValue: "\(item.quantity)")
        _notes = State(initialValue: item.notes ?? "")
        _isPacked = State(initialValue: item.isPacked)
    }

    var body: some View {

        NavigationStack {

            Form {

                PackingForm(
                    title: $title,
                    category: $category,
                    quantity: $quantity,
                    notes: $notes
                )

                Section("Status") {

                    Toggle(
                        "Packed",
                        isOn: $isPacked
                    )
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {

                        packingViewModel.updatePackingItem(
                            item: item,
                            title: title,
                            category: category,
                            quantity: Int(quantity) ?? 1,
                            notes: notes,
                            isPacked: isPacked
                        )

                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}


#Preview {

    let context = PersistenceController.preview.container.viewContext

    let item = PackingItemEntity(context: context)

    item.title = "Passport"
    item.category = "Documents"
    item.quantity = 1
    item.notes = "Keep in cabin bag"
    item.isPacked = false

    return EditPackingItemView(item: item)
        .environmentObject(PackingViewModel())
}
