//
//  MissionService.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 12/03/26.
//

import Foundation

class MissionService {

    static let shared = MissionService()
    private init() {}

    func loadChallenges() -> [Challenge] {
        guard let url = Bundle.main.url(forResource: "challenges", withExtension: "json") else {
            print("MissionService: No se encontró challenges.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(ChallengeResponse.self, from: data)
            return response.challenges
        } catch {
            print("MissionService: Error al decodificar JSON — \(error)")
            return []
        }
    }

    func fetchChallengesFromAPI() async throws -> [Challenge] {
        throw URLError(.unsupportedURL) // placeholder
    }
}
