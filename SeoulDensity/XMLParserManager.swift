import Foundation

class XMLParserManager: NSObject, XMLParserDelegate {
    private var seoulCityData: [SeoulCityData] = []
    private var currentElement = ""
    private var currentAreaName = ""
    private var currentAreaCode = ""
    private var currentAreaCongestLevel = ""
    private var currentAreaCongestMessage = ""
    private var currentAreaPopulationMin = 0
    private var currentAreaPopulationMax = 0
    private var currentMalePopulationRate = 0.0
    private var currentFemalePopulationRate = 0.0
    private var forecastData: [SeoulCityData.ForecastData] = []
    private var currentForecastTime = ""
    private var currentForecastCongestLevel = ""
    private var currentForecastMin = 0
    private var currentForecastMax = 0
    private var isParsingForecastData = false

    func parseXML(xmlData: Data) -> [SeoulCityData]? {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        return seoulCityData.isEmpty ? nil : seoulCityData
    }
    
    // MARK: - XMLParserDelegate Methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "FCST_PPLTN" {
            isParsingForecastData = true
            forecastData = []
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch currentElement {
        case "AREA_NM":
            currentAreaName += data
        case "AREA_CD":
            currentAreaCode += data
        case "AREA_CONGEST_LVL":
            currentAreaCongestLevel += data
        case "AREA_CONGEST_MSG":
            currentAreaCongestMessage += data
        case "AREA_PPLTN_MIN":
            currentAreaPopulationMin = Int(data) ?? 0
        case "AREA_PPLTN_MAX":
            currentAreaPopulationMax = Int(data) ?? 0
        case "MALE_PPLTN_RATE":
            currentMalePopulationRate = Double(data) ?? 0.0
        case "FEMALE_PPLTN_RATE":
            currentFemalePopulationRate = Double(data) ?? 0.0
        case "FCST_TIME":
            currentForecastTime += data
        case "FCST_CONGEST_LVL":
            currentForecastCongestLevel += data
        case "FCST_PPLTN_MIN":
            currentForecastMin = Int(data) ?? 0
        case "FCST_PPLTN_MAX":
            currentForecastMax = Int(data) ?? 0
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "SeoulRtd.citydata_ppltn":
            let cityData = SeoulCityData(
                areaName: currentAreaName,
                areaCode: currentAreaCode,
                areaCongestLevel: currentAreaCongestLevel,
                areaCongestMessage: currentAreaCongestMessage,
                areaPopulationMin: currentAreaPopulationMin,
                areaPopulationMax: currentAreaPopulationMax,
                malePopulationRate: currentMalePopulationRate,
                femalePopulationRate: currentFemalePopulationRate,
                latitude: 37.5665,  // Default value
                longitude: 126.9780, // Default value
                forecastData: forecastData
            )
            seoulCityData.append(cityData)
            resetCurrentValues()
            
        case "FCST_PPLTN":
            let forecast = SeoulCityData.ForecastData(
                forecastTime: currentForecastTime,
                forecastCongestLevel: currentForecastCongestLevel,
                forecastPopulationMin: currentForecastMin,
                forecastPopulationMax: currentForecastMax
            )
            forecastData.append(forecast)
            resetForecastValues()
            isParsingForecastData = false
            
        default:
            break
        }
    }
    
    private func resetCurrentValues() {
        currentAreaName = ""
        currentAreaCode = ""
        currentAreaCongestLevel = ""
        currentAreaCongestMessage = ""
        currentAreaPopulationMin = 0
        currentAreaPopulationMax = 0
        currentMalePopulationRate = 0.0
        currentFemalePopulationRate = 0.0
    }
    
    private func resetForecastValues() {
        currentForecastTime = ""
        currentForecastCongestLevel = ""
        currentForecastMin = 0
        currentForecastMax = 0
    }
}
