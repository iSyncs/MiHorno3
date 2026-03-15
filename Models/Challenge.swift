//
//  Challenge.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 12/03/26.
//

import Foundation

struct Challenge: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    let badgeName: String
    let zone: MuseumZone
    let difficulty: ChallengeDifficulty
    let xpReward: Int
    var tasks: [ChallengeTask]
    var zoneUnlocked: Bool

    var completedTasksCount: Int {
        tasks.filter { $0.isCompleted }.count
    }

    var progress: Double {
        tasks.isEmpty ? 0 : Double(completedTasksCount) / Double(tasks.count)
    }

    var isCompleted: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }

    var isInProgress: Bool {
        completedTasksCount > 0 && !isCompleted
    }
}

struct ChallengeTask: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    var isCompleted: Bool

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: rawId) ?? UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }

    init(id: UUID, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }

    enum CodingKeys: String, CodingKey {
        case id, title, isCompleted
    }
}

enum MuseumZone: String, Codable, CaseIterable {
    case general = "general"
    case cientifica = "cientifica"
    case historia   = "historia"

    var displayName: String {
        switch self {
        case .general:    return "General"
        case .cientifica: return "Área Científica"
        case .historia:   return "Museo de la Historia"
        }
    }

    var icon: String {
        switch self {
        case .general:    return "star.fill"
        case .cientifica: return "atom"
        case .historia:   return "building.columns.fill"
        }
    }

    var description: String {
        switch self {
        case .general:    return "Disponible para todos los visitantes"
        case .cientifica: return "Escanea el QR del Área Científica para desbloquear"
        case .historia:   return "Escanea el QR del Museo de la Historia para desbloquear"
        }
    }
}

enum ChallengeDifficulty: String, Codable {
    case facil   = "Fácil"
    case medio   = "Medio"
    case dificil = "Difícil"
}

enum ChallengeFilter: String, CaseIterable {
    case todos    = "Todos"
    case activos  = "Activos"
    case general = "General"
    case ciencia  = "Área Científica"
    case historia = "Historia"
}

struct ChallengeResponse: Codable {
    let challenges: [Challenge]
}
