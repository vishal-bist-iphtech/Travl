//
//  WeatherMetricCard.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct WeatherMetricCard: View {

    let title: String
    let value: String
    let systemImage: String
    let color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(color)

            Spacer()

            Text(value)
                .font(.title2.bold())

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )
    }
}

#Preview {

    LazyVGrid(
        columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ],
        spacing: 16
    ) {

        WeatherMetricCard(
            title: "Humidity",
            value: "48%",
            systemImage: "humidity.fill",
            color: .blue
        )

        WeatherMetricCard(
            title: "Wind",
            value: "12 km/h",
            systemImage: "wind",
            color: .cyan
        )

        WeatherMetricCard(
            title: "Rain",
            value: "10%",
            systemImage: "cloud.rain.fill",
            color: .indigo
        )

        WeatherMetricCard(
            title: "UV Index",
            value: "7",
            systemImage: "sun.max.fill",
            color: .orange
        )
    }
    .padding()
}
