//
//  LoginView.swift
//  New
//
//  Created by Rui Li on 10/24/20.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var pword: String = ""
    @State private var showSignUp = false
    @ObservedObject var manager = PostAuth()
    @State private var clickSearchPage = false
    @State private var showSearchPage = false
    
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                
            
            Text("COVID Test")
                .fontWeight(.bold)
                .font(.system(size: 40))
                .foregroundColor(.white)

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
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                Spacer()
                    .frame(width: 203, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action:  {
                    print("go to register")
                    self.showSignUp = true
                }){
                    Text("sign up")
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                        .frame(width: 80, height: 35, alignment: .trailing)
                }
                .sheet(isPresented: $showSignUp) {
                                        RegisterView()
                                    }
                
            }
            
            Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                print("click login")
                self.manager.postauthenticate(username: self.username, pword: self.pword)
                self.clickSearchPage = true
                if (self.clickSearchPage && self.manager.authenticated) {
                    self.showSearchPage = true
                }
            }){
                Text("login")
                    .fontWeight(.medium)
                    .font(.title)
                    .frame(width: 285, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }.sheet(isPresented: $showSearchPage) {
                SearchView()
            }
            
            if (!self.manager.authenticated && self.clickSearchPage){
                Text("Username or Password Wrong!")
                    .fontWeight(.medium)
                    .lineLimit(nil)
                    .font(.system(size: 18))
                    .foregroundColor(.red)

            }
        }
        .padding()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(
            Image("sunflower")
                .resizable()
        )
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

