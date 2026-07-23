//
//  PackingItemRow.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI
import CoreData


struct PackingItemRow: View {

    @ObservedObject var item: PackingItemEntity

    @EnvironmentObject private var packingViewModel: PackingViewModel

    var body: some View {

        HStack(spacing: 16) {

            Button {

                packingViewModel.togglePacked(item)

            } label: {

                Image(systemName: item.isPacked
                      ? "checkmark.circle.fill"
                      : "circle")
                    .font(.title2)
                    .foregroundStyle(
                        item.isPacked
                        ? .green
                        : .secondary
                    )
            }
            .buttonStyle(.plain)

            Image(systemName: icon(for: item.category))
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {

                Text(item.title ?? "")
                    .font(.headline)

                HStack(spacing: 6) {

                    Text(item.category ?? "Others")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("•")

                    Text("Qty: \(item.quantity)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if item.isPacked {

                Text("Packed")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.green.opacity(0.15))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func icon(for category: String?) -> String {

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

    let context = PersistenceController.preview.container.viewContext

    let item = PackingItemEntity(context: context)

    item.title = "Passport"
    item.category = "Documents"
    item.quantity = 1
    item.isPacked = true

    return PackingItemRow(item: item)
        .environmentObject(PackingViewModel())
        .padding()
}
