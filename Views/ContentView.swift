//
//  ContentView.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 11/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MissionView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Challenges")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Inside Map")
                }
            Sec4View()
                .tabItem {
                    Image(systemName: "apple.intelligence")
                    Text("IA")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
}
