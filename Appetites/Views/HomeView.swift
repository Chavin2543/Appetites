//
//  HomeVIew.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("isFirstTime") var isFirstTime:Bool = true
    
    @State private var isAnimating:Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        Text("Your Feed")
                            .font(.largeTitle.bold())
                        Spacer()
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

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
