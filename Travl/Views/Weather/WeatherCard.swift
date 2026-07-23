//
//  WeatherCard.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct WeatherCard: View {

    let weather: WeatherData

    var body: some View {

        VStack(alignment: .leading, spacing: 24) {

            HStack(alignment: .top) {

                VStack(alignment: .leading, spacing: 8) {

                    Text(weather.city)
                        .font(.title.bold())

                    Text(weather.condition)
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                }

                Spacer()

                Image(systemName: weather.icon)
                    .font(.system(size: 48))
                    .symbolRenderingMode(.multicolor)
            }

            HStack(alignment: .firstTextBaseline) {

                Text("\(weather.temperature)°")
                    .font(.system(size: 64, weight: .bold))

                Spacer()
            }

            Divider()
                .overlay(.white.opacity(0.3))

            HStack {

                Label(
                    "\(weather.feelsLike)°",
                    systemImage: "thermometer"
                )

                Spacer()

                Label(
                    "\(weather.windSpeed) km/h",
                    systemImage: "wind"
                )
            }
            .font(.subheadline)
            .foregroundStyle(.white.opacity(0.9))
        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.blue,
                    Color.cyan
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
        )
    }
}

#Preview {

    WeatherCard(
        weather: .sample
    )
    .padding()
}
