//
//  PackingCategoryGrid.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI

struct PackingCategoryGrid: View {

    let categories: [PackingCategory]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Item Categories")
                .font(.title3.bold())

            LazyVGrid(columns: columns, spacing: 16) {

                ForEach(categories) { category in

                    VStack(spacing: 12) {

                        Image(systemName: icon(for: category.name))
                            .font(.title)
                            .foregroundStyle(.blue)

                        Text(category.name)
                            .font(.headline)

                        Text("\(category.count) Items")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
        }
    }

    private func icon(for category: String) -> String {

        switch category {

        case "Clothes":
            return "tshirt.fill"

        case "Documents":
            return "doc.text.fill"

        case "Electronics":
            return "iphone"

        case "Toiletries":
            return "shower.fill"

        case "Medicines":
            return "cross.case.fill"

        case "Accessories":
            return "bag.fill"

        case "Food":
            return "fork.knife"

        default:
            return "shippingbox.fill"
        }
    }
}

#Preview {

    PackingCategoryGrid(
        categories: [

            PackingCategory(
                name: "Clothes",
                count: 6
            ),

            PackingCategory(
                name: "Documents",
                count: 2
            ),

            PackingCategory(
                name: "Electronics",
                count: 4
            ),

            PackingCategory(
                name: "Accessories",
                count: 3
            )
        ]
    )
    .padding()
}
