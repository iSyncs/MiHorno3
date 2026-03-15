//
//  Badge.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 12/03/26.
//

import Foundation

struct Badge: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let imageName: String
    let isUnlocked: Bool
    let xpRequired: Int
}
