//
//  BackButton.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct BackButton: View {
    @State var buttonAction: () -> Void
    var body: some View {
        HStack {
            Button(action: buttonAction) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color("NoirGrayL"))
                Text("Back")
                    .font(.footnote.bold())
                    .foregroundStyle(Color("NoirGrayL"))
            }
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(){
            print("Test")
        }
        .background(.gray)
    }
}
