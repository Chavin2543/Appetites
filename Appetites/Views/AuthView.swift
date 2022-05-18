//
//  AuthView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

public enum LoginMode {
    case login
    case register
}

struct AuthView: View {
    
    @StateObject var vm:AuthViewVM
    @State private var isAnimating:Bool = false
    @State private var mode:LoginMode = .login
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var username:String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var userService:UserDataService
    
    
    var body: some View {
            GeometryReader  { geometry in
                ZStack {
                    LoginBlob()
                        .ignoresSafeArea()
                    VStack (spacing:0) {
                        Spacer()
                        Text("Login/Signup")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width-64, height: 97, alignment: .leading)
                        HStack (spacing:112) {
                            Button {
                                withAnimation {
                                    mode = .login
                                }
                            } label: {
                                Text("Login")
                            }
                            Button {
                                withAnimation {
                                    mode = .register
                                }
                            } label: {
                                Text("Signup")
                            }
                        }
                        .font(.body.bold())
                        .foregroundColor(.white)
                        VStack {
                            TextField("Email", text: $email)
                                .frame(width: geometry.size.width-64, height: 44, alignment: .center)
                                .preferredColorScheme(.dark)
                                .textInputAutocapitalization(.never)
                            Divider()
                            if mode == .register {
                                TextField("Username", text: $username)
                                    .frame(width: geometry.size.width-64, height: 44, alignment: .center)
                                    .preferredColorScheme(.dark)
                                    .textInputAutocapitalization(.never)
                                Divider()
                                    .foregroundColor(username.isEmpty ? .red : .gray)
                            }
                            SecureField("Password", text: $password)
                                .frame(width: geometry.size.width-64, height: 44, alignment: .center)
                                .textInputAutocapitalization(.never)
                            Divider()
                            
                        }
                        .frame(height:260)
                        LongButton(title: .constant("Login"), color: .constant("NoirGreen")) {
                            if mode == .login {
                                userService.login(email: email, password: password)
                            } else {
                                userService.register(email: email, password: password, username: username)
                            }
                        }
                            .disabled(userService.isLoading)
                            .frame(width:geometry.size.width-64)
                    }
                    if userService.isLoading {
                        ZStack {
                            ProgressView("Loading")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color("NoirGreen"))
                                .cornerRadius(10)
                        }
                    }
                }
                .opacity(isAnimating ? 1 : 0)
                .frame(maxWidth:.infinity)
                .background(Color("NoirBG"))
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.6)) {
                    isAnimating = true
                }
            }
    }
}

struct AuthView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        AuthView(vm: AuthViewVM.init())
    }
}
