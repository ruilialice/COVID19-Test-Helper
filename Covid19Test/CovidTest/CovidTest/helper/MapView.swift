/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts an `MKMapView`.
*/

import SwiftUI
import MapKit

//struct MapView: UIViewRepresentable {
//
//    var templandmark: Landmark
//
//
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView(frame: .zero)
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        print(self.templandmark)
//        let temp_coordinates = self.templandmark.coordinates
//        let coordinate = CLLocationCoordinate2D(latitude: Double(temp_coordinates.latitude)!, longitude: Double(temp_coordinates.longitude)!)
//
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        uiView.setRegion(region, animated: true)
//    }
//}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: landmarkData[0].locationCoordinate)
//    }
//}
//

