//
//  LottieFood.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//
//
//  Upload.swift
//  Appetite

import Foundation
import Lottie
import SwiftUI

struct LottieFood:UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let lottieAnimationView = AnimationView(name: "Food")
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)
        
        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
