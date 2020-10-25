//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Rui Li on 10/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import SwiftUI

struct LandmarkList: View {
    var landmarkData: [Landmark]
    
    var body: some View {
        NavigationView {
            List(landmarkData) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationBarTitle(Text("Testing Places"))
        }
    }
}

//struct LandmarkList_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkList(landmarkData: decodedResponse)
//    }
//}


