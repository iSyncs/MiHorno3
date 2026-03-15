//
//  ChallengeDetailView.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 12/03/26.
//

import SwiftUI

struct ChallengeDetailView: View {

    let challenge: Challenge
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.1), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.12))
                        .frame(width: 100, height: 100)
                    Circle()
                        .stroke(Color.orange.opacity(0.3), lineWidth: 2)
                        .frame(width: 100, height: 100)
                    Image(systemName: challenge.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.orange)
                }
                .padding(.top, 36)

                VStack(spacing: 8) {
                    Text(challenge.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Completa este reto para desbloquear\n\"\(challenge.badgeName)\"")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 14) {
                    HStack {
                        Text("Paso \(challenge.completedTasksCount) de \(challenge.tasks.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(challenge.progress >= 0.75 ? "¡Casi listo!" : challenge.progress > 0 ? "En camino" : "Por iniciar")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.orange.opacity(0.15))
                                .frame(height: 8)
                            RoundedRectangle(cornerRadius: 6)
                                .fill(
                                    LinearGradient(
                                        colors: [.orange, .orange.opacity(0.7)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geo.size.width * challenge.progress, height: 8)
                        }
                    }
                    .frame(height: 8)

                    VStack(spacing: 12) {
                        ForEach(challenge.tasks) { task in
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .stroke(
                                            task.isCompleted ? Color.orange : Color.gray.opacity(0.3),
                                            lineWidth: 1.5
                                        )
                                        .frame(width: 24, height: 24)
                                    if task.isCompleted {
                                        Image(systemName: "checkmark")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                    }
                                }
                                Text(task.title)
                                    .font(.body)
                                    .foregroundColor(task.isCompleted ? .primary : .secondary)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 4)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text(challenge.isCompleted ? "¡Reto Completado! 🏆" : "Iniciar Desafío")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    ChallengeDetailView(challenge: Challenge(
        id: UUID(),
        title: "Enciende el Horno",
        description: "Activa el Alto Horno 3 paso a paso",
        icon: "flame.fill",
        badgeName: "Maestro del Fuego",
        zone: .cientifica,
        difficulty: .medio,
        xpReward: 350,
        tasks: [
            ChallengeTask(id: UUID(), title: "Escanea la zona de carga", isCompleted: false),
            ChallengeTask(id: UUID(), title: "Activa la inyección de aire", isCompleted: false),
            ChallengeTask(id: UUID(), title: "Controla la temperatura", isCompleted: false)
        ],
        zoneUnlocked: true
    ))
}
