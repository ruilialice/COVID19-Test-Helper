//
//  CurrentPos.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI
import MapKit

struct Pin: Identifiable {
    var id = UUID().uuidString
    var location: CLLocation
}

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var pins: [Pin] = []
    @Published var cur_latitude = 0.0
    @Published var cur_longitude = 0.0

    // checking authoriztion status...
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // were going to use only when in use Key only...
        if manager.authorizationStatus == .authorizedWhenInUse{
            print("authorized..")
            
            // setting reduced accuracy to true...
            
            // and updating locations...
            manager.startUpdatingLocation()
        }
        else{
            print("not authorized...")
            
            // requesting access
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("new location")
        pins.append(Pin(location: locations.last!))
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        cur_latitude = locValue.latitude
        cur_longitude = locValue.longitude
    }
}

struct CurrentPos: View {
    var managerDelegate: locationDelegate
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.8864, longitude: -78.8784), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @State var tracking: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    
    var body: some View{
        VStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: managerDelegate.pins) { pin in MapPin(coordinate: pin.location.coordinate, tint: .red)
            }
        }
        .onAppear{
            manager.delegate = managerDelegate
        }
    }
}




