//
//  LandmarkDetail.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI
import CoreLocation
import MapKit

struct LandmarkDetail: View {
    var landmark: Landmark
    
    
    var body: some View {
        VStack {
//            MapView(templandmark: landmark)
//                .edgesIgnoringSafeArea(.top)
//                .frame(height: 220)

            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Text(landmark.rating)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    FiveStarView(rating: Double(landmark.rating) ?? 0)
                        .fixedSize(horizontal: true, vertical: true)
                    Text(String(landmark.num_view)+" reviews")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack (alignment: .top) {
                    Text(landmark.category+"·"+landmark.city+"·"+landmark.state)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    Text("Address: ")
                        .font(.subheadline)
                        .bold()
                    Text(landmark.address)
                        .font(.subheadline)
                }
                HStack(alignment: .top){
                    Text("Hours: ")
                        .font(.subheadline)
                        .bold()
                    Text(landmark.hours)
                        .font(.subheadline)
                }
                HStack(alignment: .top){
                    Text("Phone:")
                        .font(.subheadline)
                        .bold()
                    Text(landmark.phone)
                        .font(.subheadline)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
               
            }
            .padding()
            
            Button(action: {
                print("click schedule")
            }){
                Text("Schedule")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 120, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            

        Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

//struct LandmarkDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkDetail(landmark: landmarkData[3])
//    }
//}


