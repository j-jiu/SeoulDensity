//
//  SplashScreen.swift
//  SeoulDensity
//
//  Created by 장지우 on 6/19/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var scaleEffect: CGFloat = 0.5
    
    var body: some View {
        VStack {
            if isActive {
                ContentView() // ContentView로 전환
            } else {
                VStack {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .scaleEffect(scaleEffect)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                self.scaleEffect = 1.0
                            }
                        }
                    Text("Seoul Density Map")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

