//
//  PostInfoFillView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import SwiftUI

struct PostInfoFillView: View {
    
    //MARK: - Properties
    var items: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)
    var image:UIImage?
    var token:String
    
    @ObservedObject var vm:PostViewVM
    
    @State private var tag1:String = ""
    @State private var tag2:String = ""
    @State private var tag3:String = ""
    
    @State private var selectedFoodTag:[String] = []
    @State private var caption:String = ""
    @State private var location:String = ""
    @State private var tagList:[String] = ["TagList1","TagList2","TagList3","TagList4","TagList5","TagList6"]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                //MARK: - Header
                
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
                
                //MARK: - HERO
//
//                    Image(uiImage: image!)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center)
//                    .clipped()
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
                        HStack {
                            Picker("Pick your food tag", selection: $tag1) {
                                        ForEach(foodTags,id:\.self) { tag in
                                            Text(tag)
                                                .foregroundColor(.black)
                                        }
                                    }
                            .pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.45)
                            .background(.white)
                            .cornerRadius(20)
                            Picker("Pick your food tag", selection: $tag2) {
                                        ForEach(foodTags,id:\.self) { tag in
                                            Text(tag)
                                                .foregroundColor(.black)
                                        }
                                    }
                            .pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.45)
                            .background(.white)
                            .cornerRadius(20)
                            Spacer()
                        }
                    }
                    .frame(width:geometry.size.width - 64)
                    Spacer()
                
                //MARK: - Footer
                    LongButton(title: .constant("Post"), color: .constant("NoirGreen")) {
                        if tag1 != "" {
                            selectedFoodTag.append(tag1)
                        }
                        if tag2 != "" {
                            selectedFoodTag.append(tag2)
                        }
                        if tag3 != "" {
                            selectedFoodTag.append(tag3)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            vm.uploadPostPhoto(image: image, token: token, caption: caption, foodTags:selectedFoodTag)
                        }
                            }
                            .frame(width:geometry.size.width - 64)
                }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
}

//struct PostInfoFillView_Previews: PreviewProvider {
//    @StateObject var vm = PostViewVM()
//    static var previews: some View {
//        PostInfoFillView(token: "", vm: vm)
//    }
//}
