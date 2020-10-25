//
//  SearchView.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI

//struct LandmarkArrayResponse: Codable {
//    var LandmarkArray: [Landmark] = Array()
//
//}



struct SearchView: View {

    @StateObject var managerDelegate = locationDelegate()
    @State private var showSearchResult = false
    @StateObject var managerSearch = postSearch()
    
        var body: some View {
            VStack {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10){
                    
                    Text("COVID test near me")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 60){
                        Button(action: {
                            print("Click search button")
                            self.showSearchResult = true
                            print(self.managerDelegate.cur_latitude)
                            self.managerSearch.postMethod(latitude: String(managerDelegate.cur_latitude), longitude: String(managerDelegate.cur_longitude))
                        }){
                            Text("Search")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
           
                        }.sheet(isPresented: $showSearchResult){
                            LandmarkList(landmarkData: self.managerSearch.SearchResponse)
                        }
                        
                        Button(action: {
                            print("I am here")
                            print("Click history button")
                        }){
                            Text("History")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                        
                }
                .frame(width: 350, height: 80, alignment: .center)
                .background(Color.init(red: 78/255, green: 94/255, blue: 109/255))
                
                CurrentPos(managerDelegate: managerDelegate)
            }

        }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

