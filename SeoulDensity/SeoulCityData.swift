import Foundation
import UIKit
//final
struct SeoulCityData {
    let areaName: String
    let areaCode: String
    let areaCongestLevel: String
    let areaCongestMessage: String
    let areaPopulationMin: Int
    let areaPopulationMax: Int
    let malePopulationRate: Double
    let femalePopulationRate: Double
    var latitude: Double
    var longitude: Double
    var forecastData: [ForecastData]
    var pinColor: UIColor {
        switch areaCongestLevel {
        case "붐빔":
            return .red
        case "약간 붐빔":
            return .orange
        case "보통":
            return .yellow
        case "여유":
            return .green
        default:
            return .gray
        }
    }
    let id = UUID()
    
    struct ForecastData: Hashable, Identifiable {
        var id = UUID()
        var forecastTime: String
        var forecastCongestLevel: String
        var forecastPopulationMin: Int
        var forecastPopulationMax: Int
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: SeoulCityData.ForecastData, rhs: SeoulCityData.ForecastData) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

