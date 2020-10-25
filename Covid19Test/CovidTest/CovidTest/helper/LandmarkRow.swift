//
//  LandmarkRow.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        HStack {
            Text(landmark.name)
            Spacer()
        }
    }
}
//
//struct LandmarkRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LandmarkRow(landmark: landmarkData[0])
//            LandmarkRow(landmark: landmarkData[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}

