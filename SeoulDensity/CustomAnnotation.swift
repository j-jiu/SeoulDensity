import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let pinColor: UIColor
    let seoulCityData: SeoulCityData

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, pinColor: UIColor, seoulCityData: SeoulCityData) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pinColor = pinColor
        self.seoulCityData = seoulCityData
        super.init()
    }

}
