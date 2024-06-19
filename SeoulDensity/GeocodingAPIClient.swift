//
//  GeocodingAPIClient.swift
//  SeoulDensity
//
//  Created by 장지우 on 6/18/24.
// 6/19modified

import Foundation
import CoreLocation

class GeocodingAPIClient {
    static let shared = GeocodingAPIClient()
    private let apiKey = "79bd9fd3705f41648bf60858f19cc51e"
    
    func geocode(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let formattedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endpoint = "https://api.opencagedata.com/geocode/v1/json?q=\(formattedAddress)&key=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let results = json?["results"] as? [[String: Any]], let geometry = results.first?["geometry"] as? [String: Any] {
                    let lat = geometry["lat"] as? Double ?? 0.0
                    let lng = geometry["lng"] as? Double ?? 0.0
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    completion(coordinate)
                } else {
                    print("Failed to parse JSON")
                    completion(nil)
                }
            } catch {
                print("Error parsing data: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
