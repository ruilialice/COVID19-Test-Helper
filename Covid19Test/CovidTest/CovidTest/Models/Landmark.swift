//
//  Landmark.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI
import CoreLocation
import MapKit

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
//    fileprivate var coordinates: Coordinates
    var city: String
    var state: String
    var category: String
    var phone: String
    var hours: String
    var rating: String
    var num_view: Int
    var address: String
    struct coordinates: Codable{
        var latitude: String
        var longitude: String
    }

//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }

}


struct Coordinates: Hashable, Codable {
    var latitude: String
    var longitude: String
}


