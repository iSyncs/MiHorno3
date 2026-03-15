//
//  HomeView.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 11/03/26.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showARCamera = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack {
                Text("Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.orange.opacity(0.4))
                
                VStack(spacing: 0) {
                    
                    GeometryReader { geo in
                        Image("horno3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                            .cornerRadius(18)
                    }
                    .padding(12)
                    
                    Image(systemName: "waveform")
                        .font(.title2)
                        .foregroundColor(.orange)
                        .padding(.vertical, 14)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 480)
            .padding(.horizontal)
            
            Button {
                showARCamera = true
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "camera.fill")
                        .font(.title2)
                    Text("Escanear")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $showARCamera) {
                Text("AR Coming Soon")
            }
            
            Spacer()
            
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeView()
}
