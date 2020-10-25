//
//  RegisterView.swift
//  New
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var pword: String = ""
    @State var confirm: String = ""
    
    func postMethod(username: String, pword: String) {
        guard let url = URL(string: "http://3.137.156.4:3000/create_tester") else {
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
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            
            VStack{
                
                TextField("username", text: $username)
                    .textFieldStyle(
                        RoundedBorderTextFieldStyle()
                    )
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 14, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                TextField("password", text: $pword)
                    .textFieldStyle(
                        RoundedBorderTextFieldStyle()
                    )
                
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    print("click sign up")
                    self.postMethod(username: username, pword: pword)
                }){
                    Text("sign up")
                        .fontWeight(.medium)
                        .font(.title)
                        .frame(width: 285, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.red)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
//                Image(systemName: "chevron.backward")
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                    .foregroundColor(.red)
//                    .frame(width: 45, height: 45, alignment: .leading)
//            }
            
        }
        .padding()
        .background(
            Image("registerpage")
                .resizable()
        )
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}


