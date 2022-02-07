//
//  ContentView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 29/1/2565 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating:Bool = false
    @AppStorage("isFirstTime") var isFirstTime:Bool = true

    @ViewBuilder var body: some View {
        GeometryReader { geometry in
            if isFirstTime {
                ZStack {
                    LottieFood()
                    VStack {
                        Spacer()
                        LongButton(
                            title: "Get Started",
                            color: "NoirYellow"
                        ) {
                            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.4)) {
                                isFirstTime = false
                            }
                        }
                            .frame(
                                width: geometry.size.width-64,
                                alignment: .center
                            )
                            .offset(x: 0, y: isAnimating ? 0 : 100)
                    }
                }
                .frame(
                    maxWidth:.infinity,
                    maxHeight: .infinity
                )
                .background(
                    ZStack {
                        Color("NoirGreen")
                        OnboardingBlob()
                            .offset(
                                x: 0,
                                y: isAnimating ? 0 : -400
                            )
                    }
                        .ignoresSafeArea()
            )
            } else {
                TabBarView()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.8), {
                isAnimating.toggle()
            })
        }
        .onDisappear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.8), {
                isAnimating.toggle()
            })
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
