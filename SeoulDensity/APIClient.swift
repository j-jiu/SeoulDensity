import Foundation

class APIClient {
    static let shared = APIClient()
    
    func fetchData(for locations: [String], completion: @escaping ([SeoulCityData]?) -> Void) {
        let apiKey = "6563624e69777230313132674e464a50"
        var allCityData: [SeoulCityData] = []
        let dispatchGroup = DispatchGroup()
        
        for location in locations {
            dispatchGroup.enter()
            let formattedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let endpoint = "http://openapi.seoul.go.kr:8088/\(apiKey)/xml/citydata_ppltn/1/5/\(formattedLocation)"
            
            guard let url = URL(string: endpoint) else {
                print("Invalid URL")
                dispatchGroup.leave()
                continue
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer { dispatchGroup.leave() }
                
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid HTTP response or status code")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                let parser = XMLParserManager()
                if let parsedData = parser.parseXML(xmlData: data) {
                    allCityData.append(contentsOf: parsedData)
                } else {
                    print("Failed to parse XML data")
                }
            }
            
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(allCityData)
        }
    }
}
