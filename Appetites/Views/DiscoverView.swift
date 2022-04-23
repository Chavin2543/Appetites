//
//  DiscoverView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct DiscoverView: View {
    var token:String?
    @State private var isTindering = false
    @State private var isAnimating:Bool = false
    @StateObject var vm = DiscoverViewVM()
    @EnvironmentObject private var userService:UserDataService
    @StateObject private var discoverService = DiscoverDataService()
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        Text("Discover\nFood for you")
                            .font(.largeTitle.bold())
                        Spacer()
                        Button {
                            vm.isSearcing = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .offset (
                        x: 0,
                        y: isAnimating ? 0 : -100
                    )
                    .foregroundColor(.white)
                    .frame (
                        width: geometry.size.width-64,
                        height: 97,
                    alignment: .leading)
                    DiscoverBadge() {
                        isTindering.toggle()
                    }
                        .offset (
                            x: isAnimating ? 0 : geometry.size.width,
                            y: 0
                        )
                        .frame (
                            width: geometry.size.width-64,
                            alignment: .center
                        )
                    CategoryTab()
                        .ignoresSafeArea()
                        .offset (
                            x: isAnimating ? 0 : -geometry.size.width,
                            y: 0
                        )
                    Spacer()
                }
            }
            .frame(maxWidth:.infinity)
            .background(Color("NoirBG"))
        }
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.4)) {
                isAnimating.toggle()
            }
        }
        .onDisappear {
            isAnimating.toggle()
        }
        .fullScreenCover(isPresented: $vm.isSearcing) {
            SearchView()
        }
        .fullScreenCover(isPresented: $isTindering) {
            DiscoverTinderView()
                .environmentObject(discoverService)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(vm: DiscoverViewVM.init())
    }
}
