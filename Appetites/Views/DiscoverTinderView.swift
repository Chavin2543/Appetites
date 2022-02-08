//
//  DiscoverTinderView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct DiscoverTinderView: View {
    // MARK: - PROPERTIES
    
    @State var showAlert: Bool = false
    @State private var isNavigatingBack:Bool = false
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition =
    AnyTransition.trailingBottom
    
    // MARK: - CARD VIEWS
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(discovers: discoverdata[index]))
        }
        return views
    }()
    
    //MARK: MOVE THE CARD
    private func moveCards() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        let discovers = discoverdata[lastCardIndex % discoverdata.count]
        let newCardView = CardView(discovers: discovers)
        
        cardViews.append(newCardView)
    }
    
    //MARK: TOP CARD
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id}) else {
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
                            isNavigatingBack = true
                        }
                    }
                    .fullScreenCover(isPresented: $isNavigatingBack) {
                        DiscoverView()
                    }.padding([.leading],32)
                    Spacer()
                }
                
                
            /*    // MARK: - OLD HEADER
                HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                    .opacity(dragState.isDragging ? 0.0 : 1.0)
                    .animation(.default)
                */
                Spacer()
                
                //Mark: - CARDS
                ZStack {
                    ForEach(cardViews) { cardView in cardView
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
                                
                                
                            })
                            ).transition(self.cardRemovalTransition)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - FOOTER
                
            }
        }
    }
}

struct DiscoverTinderView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTinderView()
            .background(Color("NoirBG"))
    }
}