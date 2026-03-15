//
//  Sec4View.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 11/03/26.
//

import SwiftUI

struct Sec4View: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Virtual Guide")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    Sec4View()
}
