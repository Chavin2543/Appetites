//
//  SearchButton.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct SearchButton: View {
    @State var buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("NoirGrayL"))
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(){
            print("Search")
        }
    }
}
