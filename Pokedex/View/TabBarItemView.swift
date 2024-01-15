//
//  SwiftUIView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 15/01/24.
//

import SwiftUI

struct TabBarItemView: View {
    let title: String
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        Text("\(title)")
            .fontWeight(.bold)
            .padding(.vertical, 10)
            .padding(.horizontal, 35)
            .clipShape(Capsule())
            .overlay(
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(color.opacity(isSelected ? 1 : 0)),
                alignment: .bottom
            )
    }
}

#Preview {
    TabBarItemView(title: "About", color: .green, isSelected: true)
}
