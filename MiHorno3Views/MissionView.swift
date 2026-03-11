//
//  MissionView.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 11/03/26.
//

import SwiftUI

struct MissionView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Missions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    MissionView()
}
