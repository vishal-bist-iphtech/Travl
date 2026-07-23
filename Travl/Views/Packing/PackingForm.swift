//
//  PackingForm.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct PackingForm: View {

    @EnvironmentObject private var packingViewModel: PackingViewModel

    @Binding var title: String
    @Binding var category: String
    @Binding var quantity: String
    @Binding var notes: String

    var body: some View {


            Section("Item") {

                TextField(
                    "Item Name",
                    text: $title
                )

                Picker(
                    "Category",
                    selection: $category
                ) {

                    ForEach(
                        packingViewModel.categories,
                        id: \.self
                    ) { category in

                        Text(category)
                            .tag(category)
                    }
                }

                TextField(
                    "Quantity",
                    text: $quantity
                )
                .keyboardType(.numberPad)
            }

            Section("Notes") {

                TextField(
                    "Optional",
                    text: $notes,
                    axis: .vertical
                )
                .lineLimit(4...8)
            }
        }
}

#Preview {

    PackingForm(

        title: .constant("Passport"),

        category: .constant("Documents"),

        quantity: .constant("1"),

        notes: .constant("Keep in cabin bag")
    )
    .environmentObject(PackingViewModel())
}
