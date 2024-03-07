//
//  SplashView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 7/3/2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var progress: Progress
    
    var body: some View {
        VStack(spacing: 0){
            Image("Logo")
                .resizable()
                .scaledToFit()
                .padding(64)
            
            ProgressView(value: progress.fractionCompleted)
                .frame(width: 200)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yaDarkPurple)
    }
}

#Preview {
    SplashView(progress: Progress(totalUnitCount: 100, parent: .current() ?? Progress(), pendingUnitCount: 30))
}
