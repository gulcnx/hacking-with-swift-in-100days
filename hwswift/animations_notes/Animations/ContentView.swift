//
//  ContentView.swift
//  Animations
//
//  Created by gülçin çetin on 3.08.2025.
//

import SwiftUI

struct CornerRotateModifier : ViewModifier {
    let amount: Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation{
                isShowingRed.toggle()
                
            }
        }
    }
        
}

#Preview {
    ContentView()
}

//        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(.rect(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged{ dragAmount = $0.translation}
//                    .onEnded{ _ in
//                        withAnimation(.bouncy){
//                            dragAmount = .zero
//                        }
//                    }
//            )
//            .animation(.bouncy, value : dragAmount)
       

//
//HStack(spacing: 0) {
//    ForEach(0..<letters.count, id: \.self) { num in
//        Text(String(letters[num]))
//            .padding(5)
//            .font(.title)
//            .background(enabled ? .yellow : .pink)
//            .offset(dragAmount)
//            .animation(.linear.delay(Double(num) / 20), value: dragAmount)
//    }
//}
//.gesture(
//    DragGesture()
//        .onChanged { dragAmount = $0.translation }
//        .onEnded { _ in
//            dragAmount = .zero
//            enabled.toggle()
//        }
//)

//
//@State private var isShowingRed = false
//
//var body: some View {
//    // Wholly custom transitions
//    VStack{
//        Button("Tap me") {
//            withAnimation {
//                isShowingRed.toggle()
//            }
//        }
//        if isShowingRed {
//            Rectangle()
//                .fill(.red)
//                .frame(width: 200, height: 200)
//                .transition(.asymmetric(insertion: .scale, removal: .opacity))
//        }
//    }
