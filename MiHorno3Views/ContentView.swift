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
                    Text("Missions")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            Sec4View()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Sec4")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
}
