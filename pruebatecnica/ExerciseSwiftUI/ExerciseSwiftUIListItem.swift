//
//  ExerciseSwiftUIListItem.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 15/2/24.
//

import SwiftUI

struct ExerciseSwiftUIListItem: View {
    
    // MARK: - Properties
    
    let imageName: String
    let title: String
    
    @State private var onTapAnimation: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            
            // Imagen
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 128)
            
            // Velo
            Color.black
                .opacity(0.35)
            
            // Texto
            VStack {
                Spacer()
                Text(title)
                    .font(.system(.footnote, design: .serif))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            } //: Text
            
        } //: ZSTACK
        .frame(height: 128)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(onTapAnimation ? 0.9 : 1, anchor: .center)
        .animation(.easeOut(duration: 0.1), value: onTapAnimation)
        .onTapGesture {
            withAnimation {
                onTapAnimation.toggle()
            }
        }
    }
}

#Preview {
    ExerciseSwiftUIListItem(imageName: "ingredients_1", title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
}
