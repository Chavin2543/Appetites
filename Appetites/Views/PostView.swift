//
//  PostView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import SwiftUI
import SDWebImage

struct PostView: View {
    
    @StateObject private var vm = PostViewVM()
    @State private var fillInfo:Bool = false
    @Binding var selectedTab:Tab
    @State var token:String
    @State var image:UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack (alignment:.center,spacing:0) {
                    HStack {
                        Text("Create\nPost")
                            .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        Spacer()
                        if image != nil {
                            Button {
                                fillInfo.toggle()
//                                vm.uploadPostPhoto(image: image, token: token, caption: vm.caption)
//                                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                                    selectedTab = .home
//                                }
                            } label: {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .foregroundColor(.white)
                            }

                        }
                    }
                    Button {
                        vm.showImagePicker.toggle()
                    } label: {
                        ZStack {
                            if image != nil {
                                Image(uiImage: image!.downsampled(by: 0.7)!)
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: geometry.size.width-40, height: geometry.size.height-220, alignment: .center)
                                    .cornerRadius(44)
                                    .padding()
                                
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 44)
                                        .frame(width: 311, height: 311, alignment: .center)
                                    .foregroundColor(Color("NoirGrayD"))
                                    Image(systemName: "plus")
                                        .font(.largeTitle.bold())
                                        .foregroundColor(.white)
                                }
                                .padding()
                               
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $vm.showImagePicker) {
                        ImagePicker(image:$image)
                    }
                    Spacer()
//                    LongButton(title: .constant("Post"), color: .constant("NoirGreen")) {
//                        vm.uploadPostPhoto(image: image, token: token, caption: vm.caption)
//                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                            selectedTab = .home
//                        }
//                    }
                }
                .frame(width:geometry.size.width-64)
            }
            .fullScreenCover(isPresented: $fillInfo, content: {
                PostInfoFillView(image: image)
            })
            .onAppear(perform: {
                if image == nil {
                    vm.showImagePicker = true
                }
            })
            .onDisappear(perform: {
                SDImageCache.shared.clearMemory()
            })
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(selectedTab: .constant(Tab.home), token: "")
    }
}
