//
//  PostAuth.swift
//  CovidTest
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI

//struct ServerMessage: Decodable {
//    let res, message: String
//}

struct temp_message: Decodable {
    var message: String
}

class PostAuth: ObservableObject {
    
    @Published var authenticated = false
    
    
    func postauthenticate(username: String, pword: String) {
        guard let url = URL(string: "http://3.137.156.4:3000/validate_tester") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let userName: String
            let password: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(userName: username, password: pword)
        
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
            let decodedResponse = try? JSONDecoder().decode(temp_message.self, from: data)

            if decodedResponse?.message=="wrong" {
                self.authenticated = false
            }
            if decodedResponse?.message=="correct" {
                self.authenticated = true
            }

        }.resume()
            
    }
}


