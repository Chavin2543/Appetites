//
//  DiscoverTinderView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 13/4/2565 BE.
//

import SwiftUI

struct DiscoverTinderView: View {
    @EnvironmentObject private var userService:UserDataService
    @EnvironmentObject private var postService:PostDataService
    @EnvironmentObject private var discoverService:DiscoverDataService
    @Environment(\.presentationMode) private var presentationMode
    @State var showAlert: Bool = false
    @State var bookmartIndex:Int = 0
    @State private var isNavigatingBack:Bool = false
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition =
    AnyTransition.trailingBottom
    
    // MARK: - CARD VIEWS
    
//    @State var cardViews: [CardView] = {
//        var views = [CardView]()
//        for index in 0..<2 {
//            views.append(CardView(discovers: DiscoverTinderMenu[index]))
//        }
//        return views
//    }()
    
    //MARK: MOVE THE CARD
    private func moveCards() {
        print("REMOVE : \(discoverService.displayPosts.first) And Count = \(discoverService.displayPosts.count) ")
        discoverService.displayPosts.removeFirst()
        self.lastCardIndex += 1
        if discoverService.displayPosts.count == 0 {
            discoverService.retrieveRecommendedPost(token: userService.token)
        }
    }
    
    //MARK: TOP CARD
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = discoverService.displayPosts.firstIndex(where: { $0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    // MARK: DRAG STATES
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                //MARK: NEW HEADER
                HStack {
                    HStack{
                        BackButton() {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding([.leading],32)
                    Spacer()
                }
                Spacer()
                //MARK: - CARDS
                ZStack {
                    ForEach(discoverService.displayPosts) { cardView in cardView
                            .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                            .overlay(
                                ZStack {
                                    Image(systemName: "x.circle")
                                        .modifier(SymbolModifier())
                                        .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                    
                                    
                                    Image(systemName: "bookmark.circle") //BOOKMARK SIGN
                                        .modifier(SymbolModifier())
                                        .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                }
                            )
                            .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ?  self.dragState.translation.height : 0)
                            .opacity(self.isTopCard(cardView: cardView) ? 1 : 0)
                            .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.85 : 1.0)
                            .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ?  Double(self.dragState.translation.width / 12) : 0))
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                            .gesture(LongPressGesture(minimumDuration: 0.01)
                                        .sequenced(before: DragGesture())
                                        .updating(self.$dragState, body: {(value, state, transaction) in
                                                  switch value {
                                                  case .first(true):
                                                    state = .pressing
                            case .second(true, let drag):
                                state = .dragging(translation: drag?.translation ?? .zero)
                            default:
                                break
                            }
                            })
                            .onChanged({ (value) in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }
                                if drag.translation.width < -self.dragAreaThreshold {
                                    self.cardRemovalTransition = .leadingBottom
                                }
                                if drag.translation.width > self.dragAreaThreshold {
                                    self.cardRemovalTransition = .trailingBottom
                                }
                            })
                            .onEnded({ (value) in
                                guard case .second(true, let drag?) = value else { return }
                                if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                    //playSound(sound: "sound-rise", type: "mp3")
                                    self.moveCards()
                                }
                                
                                //MARK: -TODO LOGEVENT
                                if drag.translation.width < -self.dragAreaThreshold {
                                    print("SWIPE : LEFT Ignore Post")
                                    bookmartIndex += 1
                                } else if drag.translation.width > self.dragAreaThreshold {
                                    print("SWIPE : RIGHT Log Event to Owen")
                                    discoverService.logBookmark(token: userService.token, postID:"\(discoverService.recommendedPost[bookmartIndex].postID)")
                                    bookmartIndex += 1
                                }
                                
                                
                            })
                            ).transition(self.cardRemovalTransition)
                    }
                }
                .onAppear(perform: {
                    discoverService.retrieveRecommendedPost(token: userService.token)
                })
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - FOOTER
                
            }
        }
        .background(Color("NoirBG"))
    }
}

struct DiscoverTinderView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTinderView()
            .environmentObject(DiscoverDataService())
    }
}
