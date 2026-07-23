//
//  PackingsView.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI
import CoreData

struct PackingDetailView: View {

    @EnvironmentObject private var packingViewModel: PackingViewModel
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var item: PackingItemEntity

    @State private var showDeleteAlert = false

    var body: some View {

        List {

            Section("Packing Item") {

                DetailRow(
                    title: "Item",
                    value: item.title ?? "-"
                )

                DetailRow(
                    title: "Category",
                    value: item.category ?? "-"
                )

                DetailRow(
                    title: "Quantity",
                    value: "\(item.quantity)"
                )

                DetailRow(
                    title: "Status",
                    value: item.isPacked ? "Packed" : "Not Packed"
                )
            }

            if let notes = item.notes,
               !notes.isEmpty {

                Section("Notes") {

                    Text(notes)
                }
            }
        }
        .navigationTitle("Packing Item")
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                NavigationLink {

                    EditPackingItemView(item: item)
                        .environmentObject(packingViewModel)

                } label: {

                    Image(systemName: "square.and.pencil")
                }

                Button(role: .destructive) {

                    showDeleteAlert = true

                } label: {

                    Image(systemName: "trash")
                }
            }
        }
        .alert(
            "Delete Packing Item?",
            isPresented: $showDeleteAlert
        ) {

            Button(
                "Delete",
                role: .destructive
            ) {

                packingViewModel.deletePackingItem(item)

                dismiss()
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: {

            Text("This action cannot be undone.")
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
    item.isPacked = true

    return NavigationStack {

        PackingDetailView(item: item)
    }
    .environmentObject(PackingViewModel())
}
