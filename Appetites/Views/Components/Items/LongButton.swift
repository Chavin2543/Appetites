//
//  LongButton.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct LongButton: View {
    @Binding var title:String
    @Binding var color:String
    @State var buttonAction: () -> Void
    
    var body: some View {
            Button ( action:buttonAction , label: {
                    ZStack {
                        Color("\(color)")
                        Text("\(title)")
                            .font(.callout.bold())
                        .foregroundColor(.white)
                    }
                    .frame(height: 49, alignment: .center)
                    .frame(maxWidth:.infinity)
                    .cornerRadius(44.0)
                }
            )
    }
}

struct LongButton_Previews: PreviewProvider {
    static var previews: some View {
        LongButton(title: .constant("Test"),color: .constant("NoirGreen")) {
            print("Test")
        }
    }
}
