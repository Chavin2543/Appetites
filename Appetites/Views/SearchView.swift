//
//  SearchView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct SearchView: View {
    
    @State private var isAnimating:Bool = false
    @EnvironmentObject private var postService:PostDataService
    @EnvironmentObject private var userService:UserDataService
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm = SearchViewVM()
    
    var body: some View {
        GeometryReader  { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.body.bold())
                                .padding(.leading,8)
                            TextField("Search", text: $vm.searchText)
                                .font(.body.bold())
                                .frame(height:40)
                                .onChange(of: vm.searchText) { newValue in
                                    if(vm.searchText != "") {
                                        vm.search(token: userService.token)
                                    }
                            }
                        }
                        .background(Color("NoirGrayD"))
                        .cornerRadius(20)
                        .frame(width:geometry.size.width-36,height:80)
                        if vm.searchResult.searchResult.first?.username != "" {
                            ForEach(vm.searchResult.searchResult) { user in
                                NavigationLink(destination: OtherProfileView(otherUser: user)) {
                                    UserSearchResult(userInfo:user)
                                        .frame(width: geometry.size.width-52, height: 72, alignment: .center)
                                        .opacity(isAnimating ? 1 : 0)
                                        .offset(x: isAnimating ? 0 : geometry.size.width, y: 0)
                                        .onAppear(perform: {
                                            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.4)) {
                                                isAnimating = true
                                            }
                                        })
                                }

                            }
                        }
                        Spacer()
                    }
                    .navigationTitle("Search")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                            }

                        }
                    }
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color("NoirBG"))
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
