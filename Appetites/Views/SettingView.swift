//
//  SettingView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct SettingView: View {
    
    @State private var isAnimating:Bool = true
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    @StateObject var vm: SettingViewVM
    
    var body: some View {
        GeometryReader { geometry in
                ScrollView {
                    VStack (alignment:.leading , spacing: 0) {
                        UserStatusBadge()
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                        Spacer()
                        if userService.isAuthenticated {
                            Button {
                                userService.logout()
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack {
                                    Image(systemName:"arrow.down.right.and.arrow.up.left")
                                        .foregroundColor(.white)
                                    Text("Log Out")
                                        .font(.body)
                                    .foregroundColor(.red)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal,16)
                                .frame(height:70)
                                .background(Color("NoirGrayD"))
                            }
                        }
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Image(systemName:"arrow.down.right.and.arrow.up.left")
                                    .foregroundColor(.white)
                                Text("Close setting")
                                    .font(.body)
                                .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal,16)
                            .frame(height:70)
                            .background(Color("NoirGrayD"))
                        }

                    }
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color("NoirBG"))
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(vm: SettingViewVM.init())
    }
}
