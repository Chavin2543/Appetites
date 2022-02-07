//
//  SearchView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct SearchView: View {
    
    @State private var isAnimating:Bool = false
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm = SearchViewVM()
    @State var token:String
    
    var body: some View {
        GeometryReader  { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        TextField("Search", text: $vm.searchText)
                            .frame(width:geometry.size.width-36)
                            .onChange(of: vm.searchText) { newValue in
                                if(vm.searchText != "") {
                                    vm.search(token: token)
                                }
                            }
                        if vm.searchResult.searchResult.first?.username != "" {
                            ForEach(vm.searchResult.searchResult) { user in
                                NavigationLink(destination: OtherProfileView(username: user.username)) {
                                    UserSearchResult(userInfo:user)
                                        .frame(width: geometry.size.width-36, height: 100, alignment: .center)
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
        SearchView(token: "")
    }
}
