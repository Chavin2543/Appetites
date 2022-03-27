//
//  PostInfoFillView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import SwiftUI

struct PostInfoFillView: View {
    var items: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)
    var image:UIImage?
    @State private var foodtag:[String] = []
    @State private var caption:String = ""
    @State private var location:String = ""
    @State private var tagList:[String] = ["TagList1","TagList2","TagList3","TagList4","TagList5","TagList6"]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button {
                        print("back")
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.horizontal,16)
                    }
                    .padding(.leading,32)

                    Text("Fill Information")
                        .font(.title)
                        .fontWeight(.bold)
                    .foregroundColor(.white)
                    Spacer()
                }
                    Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center)
                    .clipped()
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Caption")
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .padding(.leading,32)
                        HStack {
                            TextEditor(text: $caption)
                                .frame(height:140)
                                .cornerRadius(20)
                                .padding()
                                .font(.caption)
                                .frame(width:geometry.size.width)
                                .foregroundColor(.black)
                                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 2)
                        }
                        Text("Location")
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .padding(.leading,32)
                        TextField("Location", text: $location)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.leading,32)
                    }
                
                
                    VStack (alignment:.leading) {
                            Text("Food Tag")
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(.white)
                                .padding(.leading,32)
                            LazyVGrid(columns: items, alignment: .center, spacing: 4) {
                                ForEach(tagList,id:\.self) { item in
                                    ZStack {
                                        Capsule()
                                            .foregroundColor(Color(foodtag.contains(item) ?
                                                                   "NoirGreen" : "NoirRed"))
                                            .frame(width: 80, height: 25, alignment: .center)
                                            .padding(5)
                                            .onTapGesture {
                                                if let index = foodtag.firstIndex(of: item) {
                                                    foodtag.remove(at: index)
                                                } else {
                                                    foodtag.append(item)
                                                }
                                                print("\(foodtag)")
                                            }
                                        Text("\(item)")
                                            .font(.caption.bold())
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                    }
                    Spacer()
                                    LongButton(title: .constant("Post"), color: .constant("NoirGreen")) {
//                                        vm.uploadPostPhoto(image: image, token: token, caption: vm.caption)
//                                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                                            selectedTab = .home
//                                        }
                                    }
                                    .frame(width:geometry.size.width - 64)
                }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
}

struct PostInfoFillView_Previews: PreviewProvider {
    static var previews: some View {
        PostInfoFillView()
    }
}
