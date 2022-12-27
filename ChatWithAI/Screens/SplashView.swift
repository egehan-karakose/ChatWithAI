//
//  SplashView.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var isRotating = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "gear.circle")
                        .font(.system(size: 200))
                        .foregroundColor(.orange)
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                        }
                    Text("CWA")
                        .font(.system(size: 60))
                        .bold()
                        .foregroundColor(.orange)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
