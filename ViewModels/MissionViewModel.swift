//
//  MissionViewModel.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 12/03/26.
//

import Foundation
import Observation

@Observable
@MainActor
class MissionViewModel {

    var challenges: [Challenge] = []
    var selectedFilter: ChallengeFilter = .todos

    private let service = MissionService.shared

    var filteredChallenges: [Challenge] {
        switch selectedFilter {
        case .todos:
            return challenges
        case .activos:
            return challenges.filter { $0.zoneUnlocked && !$0.isCompleted }
        case .general:
            return challenges.filter { $0.zone == .general }
        case .ciencia:
            return challenges.filter { $0.zone == .cientifica }
        case .historia:
            return challenges.filter { $0.zone == .historia }
        }
    }

    var challengesByZone: [(zone: MuseumZone, challenges: [Challenge], unlocked: Bool)] {
        MuseumZone.allCases.compactMap { zone in
            let zoneChallenges = filteredChallenges.filter { $0.zone == zone }
            guard !zoneChallenges.isEmpty else { return nil }
            let unlocked = zoneChallenges.first?.zoneUnlocked ?? false
            return (zone: zone, challenges: zoneChallenges, unlocked: unlocked)
        }
    }

    init() {
        challenges = service.loadChallenges()
    }

    func unlockZone(_ zone: MuseumZone) {
        for i in challenges.indices where challenges[i].zone == zone {
            challenges[i].zoneUnlocked = true
        }
    }
}
