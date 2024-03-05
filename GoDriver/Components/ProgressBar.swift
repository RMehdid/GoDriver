//
//  ProgressBar.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI

struct ProgressBar: View {
    
    let secondsAlive: Int
    
    @State private var progress: CGFloat = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        self.progress = proxy.size.width
                    }
                    .foregroundStyle(Color(red: 247 / 255, green: 243 / 255, blue: 248 / 255))
                
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(height: 2)
                    .frame(width: progress)
                    .foregroundStyle(Color(red: 99 / 255, green: 22 / 255, blue: 219 / 255))
            }
            .onReceive(timer) { _ in
                progress -= (proxy.size.width / CGFloat((secondsAlive * 10)))
            }
        }
    }
}

#Preview {
    ProgressBar(secondsAlive: 15)
        .padding()
}
