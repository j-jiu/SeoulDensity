import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let pinColor: UIColor

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, pinColor: UIColor) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pinColor = pinColor
        super.init()
    }

}
