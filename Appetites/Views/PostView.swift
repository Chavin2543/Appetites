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
    @Binding var selectedTab:Tab
    @State var token:String
    @State var image:UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack (alignment:.center,spacing:40) {
                    HStack {
                        Text("Create\nPost")
                            .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        Spacer()
                    }
                    Button {
                        vm.showImagePicker.toggle()
                    } label: {
                        ZStack {
                            if image != nil {
                                Image(uiImage: image!.downsampled(by: 0.7)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width-64, height: geometry.size.width-64, alignment: .center)
                                    .clipped()
                                    .cornerRadius(44)
                            } else {
                                RoundedRectangle(cornerRadius: 44)
                                    .frame(width: 311, height: 311, alignment: .center)
                                .foregroundColor(Color("NoirGrayD"))
                                Image(systemName: "plus")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .sheet(isPresented: $vm.showImagePicker) {
                        ImagePicker(image:$image)
                    }
                    
                    TextField("Caption", text: $vm.caption)
                        .preferredColorScheme(.dark)
                        .background(
                            Capsule()
                                .foregroundColor(Color("NoirGrayD"))
                                .frame(height:50)
                        )
                        .frame(width:geometry.size.width-128)
                        .multilineTextAlignment(.center)
                    Spacer()
                    LongButton(title: .constant("Post"), color: .constant("NoirGreen")) {
                        vm.uploadPostPhoto(image: image, token: token, caption: vm.caption)
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            selectedTab = .home
                        }
                    }
                    .offset(x: 0, y: -97)
                }
                .frame(width:geometry.size.width-64)
            }
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
