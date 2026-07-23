//
//  WeatherData.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import Foundation

struct WeatherData {

    let city: String
    let temperature: Int
    let condition: String
    let icon: String

    let feelsLike: Int
    let humidity: Int
    let windSpeed: Int
    let rainChance: Int
    let uvIndex: Int

    let hourly: [HourlyWeather]
    let weekly: [DailyWeather]
}

struct HourlyWeather: Identifiable {

    let id = UUID()

    let time: String
    let icon: String
    let temperature: Int
}

struct DailyWeather: Identifiable {

    let id = UUID()

    let day: String
    let icon: String
    let high: Int
    let low: Int
}
