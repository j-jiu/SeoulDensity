import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var seoulCityData: [SeoulCityData]
    @Binding var selectedAnnotation: CustomAnnotation?
        
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        
        // 사용자 위치 권한 요청
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // CustomAnnotation 추가
        for data in seoulCityData {
            let annotation = CustomAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude),
                title: data.areaName,
                subtitle: "인구: \(data.areaPopulationMin) - \(data.areaPopulationMax)",
                pinColor: data.pinColor,
                seoulCityData: data // CustomAnnotation에 SeoulCityData 전달
            )
            mapView.addAnnotation(annotation)
        }
        
        // 초기 지역 서울로 설정
        let seoulLatitude = 37.5665
        let seoulLongitude = 126.9780
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: seoulLatitude, longitude: seoulLongitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)

        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        
        for data in seoulCityData {
            let annotation = CustomAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude),
                title: data.areaName,
                subtitle: "인구: \(data.areaPopulationMin) - \(data.areaPopulationMax)",
                pinColor: data.pinColor,
                seoulCityData: data
            )
            mapView.addAnnotation(annotation)
        }
        
        // 서울의 좌표
        let seoulLatitude = 37.5665
        let seoulLongitude = 126.9780
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: seoulLatitude, longitude: seoulLongitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? CustomAnnotation else { return nil }
            
            let identifier = "CustomMarker"
            var view: MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            view.markerTintColor = annotation.pinColor
            return view
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let annotation = view.annotation as? CustomAnnotation {
                parent.selectedAnnotation = annotation
                
                // 선택된 위치로 지도 중심 이동
                let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                mapView.setRegion(region, animated: true)
            }
        }
    }
}
