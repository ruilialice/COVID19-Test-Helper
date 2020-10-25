//
//  postSearch.swift
//  CovidTest
//
//  Created by Rui Li on 10/25/20.
//

import SwiftUI



//struct postSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        postSearch()
//    }
//}

class postSearch: ObservableObject {
    @Published var SearchResponse:[Landmark] = []
    
    func postMethod(latitude: String, longitude: String) {
        
        guard let url = URL(string: "http://3.137.156.4:3000/search_pos") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let latitude: String
            let longitude: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(latitude: latitude, longitude: longitude)
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
    
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            self.SearchResponse = try! JSONDecoder().decode([Landmark].self, from: data)

            
        }.resume()
    }
}

