import SwiftUI

//yet : forecast
struct LocationDetailView: View {
    let annotation: CustomAnnotation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(annotation.title ?? "")
                    .font(.title)
                    .padding(.top)
                Text(annotation.subtitle ?? "")
                    .font(.subheadline)
                    .padding(.bottom)
                
                Divider()
                
                Text("현재 혼잡도 수준: \(annotation.seoulCityData.areaCongestLevel)")
                Text("혼잡도 메시지: \(annotation.seoulCityData.areaCongestMessage)")
                Text("최소 인구: \(annotation.seoulCityData.areaPopulationMin)")
                Text("최대 인구: \(annotation.seoulCityData.areaPopulationMax)")
                Text("남성 인구 비율: \(String(format: "%.2f", annotation.seoulCityData.malePopulationRate))%")
                Text("여성 인구 비율: \(String(format: "%.2f", annotation.seoulCityData.femalePopulationRate))%")
                
                Divider()
                
//                Text("예측 데이터:")
//                    .font(.headline)
//                
//                // Sort forecastData by forecastTime
//                let sortedForecasts = annotation.seoulCityData.forecastData.sorted { $0.forecastTime < $1.forecastTime }
//                
//                ForEach(sortedForecasts, id: \.self) { forecast in
//                    VStack(alignment: .leading) {
//                        Text("시간: \(formatTime(forecast.forecastTime))")
//                        Text("혼잡도 수준: \(forecast.forecastCongestLevel)")
//                        Text("최소 인구: \(forecast.forecastPopulationMin)")
//                        Text("최대 인구: \(forecast.forecastPopulationMax)")
//                    }
//                    .padding(.bottom, 8)
//                }
            }
            .padding()
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
//    private func formatTime(_ timeString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        if let date = dateFormatter.date(from: timeString) {
//            dateFormatter.dateFormat = "yyyy-MM-dd HH시"
//            return dateFormatter.string(from: date)
//        }
//        return timeString
//    }
}
