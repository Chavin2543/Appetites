//
//  HeartButtonComponent.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isLiked: Bool
    
    var body: some View{
        Button(action: {
            self.isLiked.toggle()
        }, label: {
            Image(systemName: "heart.fill")
                .foregroundColor(isLiked ? .red : (Color("NoirGrayL")))
        })
    }
}

