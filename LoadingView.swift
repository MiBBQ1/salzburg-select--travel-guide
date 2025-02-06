//
//  LoadingView.swift
//  Salzburg Select  Travel Guide
//
//  Created by o.chetverykov on 21.01.2025.
//


import SwiftUI

struct LoadingView: View {
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image("Group 1") // Замените на название вашего изображения логотипа "S"
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)

                Image("Group 2 (8)") // Замените на изображение текста "SALZBURG SELECT"
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)

                Image("Travel Guide.") // Замените на изображение текста "Travel Guide."
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                Spacer()
            }
            .opacity(opacity) // Устанавливаем текущую непрозрачность
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    opacity = 1.0
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
