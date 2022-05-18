//
//  PostInfoFillView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import SwiftUI

struct PostInfoFillView: View {
    
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
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
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                //MARK: - Header
                
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
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
                .padding(.top,30)
                
                //MARK: - HERO
                //
                //                    Image(uiImage: image!)
                //                    .resizable()
                //                    .scaledToFill()
                //                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center)
                //                    .clipped()
                VStack (alignment: .leading, spacing: 30) {
                    Group {
                        TextField("Caption", text: $caption)
                        Divider()
                        TextField("Location", text: $location)
                        Divider()
                        Text("Select Your FoodTag")
                            .font(.body.bold())
                        if selectedFoodTag.count < 3 {
                            Picker("Pick your food tag", selection: $tag1.onChange(tagChange)) {
                                ForEach(foodTags, id: \.self) {
                                    Text($0)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(width: 200, height: 20, alignment: .center)
                            .padding(3)
                            .background(.white)
                            .cornerRadius(24)
                        }
                        Divider()
                    }
                }
                .preferredColorScheme(.dark)
                .padding(.horizontal,32)
                .padding(.vertical,32)
                
                
                VStack (alignment:.leading) {
                    HStack {
                        VStack (spacing: 30) {
                            HStack (spacing:10) {
                                ForEach(selectedFoodTag, id:\.self) { tag in
                                    HStack {
                                        Text(tag)
                                            .frame(width: 45, height: 5, alignment: .center)
                                        Button {
                                            let index = selectedFoodTag.firstIndex(of: tag) ?? 0
                                            selectedFoodTag.remove(at: index)
                                        } label: {
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color("NoirGreen"))
                                    .cornerRadius(25)
                                    .font(.caption)
                                    
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(width:geometry.size.width - 64)
                Spacer()
                
                //MARK: - Footer
                LongButton(title: .constant("Post"), color: .constant("NoirGreen")) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        vm.uploadPostPhoto(image: image, token: token, caption: caption, foodTags:selectedFoodTag, postLocation: location)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .frame(width:geometry.size.width - 64)
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
    
    func tagChange(_ tag:String) {
        selectedFoodTag.append(tag)
        print(selectedFoodTag)
        let index = foodTags.firstIndex(of: tag) ?? 0
        foodTags.remove(at: index)
    }
}

//struct PostInfoFillView_Previews: PreviewProvider {
//    @StateObject var vm = PostViewVM()
//    static var previews: some View {
//        PostInfoFillView(token: "", vm: vm)
//    }
//}
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
            })
    }
}
