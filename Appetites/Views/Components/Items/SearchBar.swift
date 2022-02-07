//
//  SearchBar.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct SearchBar: View {
    @State var text:String
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .font(.body)
                .foregroundStyle(Color("NoirGrayL"))
            Spacer()
            Button {
                print("Searching")
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
            }
        }
        .frame(height:97)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: "Hello")
            .background(.black)
    }
}
