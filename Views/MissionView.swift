//
//  MissionView.swift
//  MiHorno3
//
//  Created by Carlos Baranda on 11/03/26.
//

import SwiftUI

struct MissionView: View {

    @State private var viewModel = MissionViewModel()
    @State private var startedChallenge: Challenge? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.orange.opacity(0.12), Color(.systemGroupedBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        filterChips

                        VStack(spacing: 16) {
                            challengesList
                        }
                        .padding(.horizontal)

                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Desafíos")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $startedChallenge) { challenge in
                ChallengeStartedView(challenge: challenge)
            }
        }
    }

    var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ChallengeFilter.allCases, id: \.self) { filter in
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            viewModel.selectedFilter = filter
                        }
                    } label: {
                        Text(filter.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(viewModel.selectedFilter == filter ? .white : .secondary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(viewModel.selectedFilter == filter
                                          ? Color.orange
                                          : Color(.systemBackground))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(viewModel.selectedFilter == filter
                                            ? Color.clear
                                            : Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    var challengesList: some View {
        VStack(spacing: 20) {
            if viewModel.challengesByZone.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.4))
                    Text("No hay desafíos en esta categoría")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                ForEach(viewModel.challengesByZone, id: \.zone) { group in
                    VStack(spacing: 10) {

                        HStack(spacing: 10) {
                            Image(systemName: group.zone.icon)
                                .font(.subheadline)
                                .foregroundColor(group.unlocked ? .orange : .gray)
                            Text(group.zone.displayName)
                                .font(.headline)
                            Spacer()
                            if group.unlocked {
                                Label("Desbloqueada", systemImage: "checkmark.seal.fill")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.orange.opacity(0.1))
                                    .clipShape(Capsule())
                            } else {
                                Label("QR requerido", systemImage: "qrcode")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(Capsule())
                            }
                        }

                        if !group.unlocked {
                            HStack(spacing: 12) {
                                Image(systemName: "qrcode.viewfinder")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Zona bloqueada")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                    Text(group.zone.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                        } else {
                            ForEach(group.challenges) { challenge in
                                ChallengeCard(challenge: challenge) {
                                    startedChallenge = challenge
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ChallengeCard: View {
    let challenge: Challenge
    let onTap: () -> Void

    var difficultyColor: Color {
        switch challenge.difficulty {
        case .facil:   return .green
        case .medio:   return .orange
        case .dificil: return .red
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(challenge.zoneUnlocked
                              ? Color.orange.opacity(0.12)
                              : Color.gray.opacity(0.08))
                        .frame(width: 48, height: 48)
                    Image(systemName: challenge.zoneUnlocked ? challenge.icon : "lock.fill")
                        .font(.title3)
                        .foregroundColor(challenge.zoneUnlocked ? .orange : .gray)
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(challenge.title)
                            .font(.headline)
                            .foregroundColor(challenge.zoneUnlocked ? .primary : .secondary)
                        Spacer()
                        statusPill
                    }
                    Text(challenge.zone.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(spacing: 6) {
                        difficultyTag
                        xpTag
                    }
                }
            }
            .padding()

            if challenge.zoneUnlocked {
                Divider().padding(.horizontal)

                HStack(spacing: 12) {
                    VStack(spacing: 4) {
                        HStack {
                            Text("Paso \(challenge.completedTasksCount) de \(challenge.tasks.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(Int(challenge.progress * 100))%")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.orange)
                        }
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.orange.opacity(0.15))
                                    .frame(height: 5)
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.orange)
                                    .frame(width: geo.size.width * challenge.progress, height: 5)
                            }
                        }
                        .frame(height: 5)
                    }
                    .frame(maxWidth: .infinity)

                    Button(action: onTap) {
                        Text(challenge.isInProgress ? "Continuar" : challenge.isCompleted ? "Ver" : "Iniciar")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(challenge.isInProgress ? .orange : .white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(challenge.isInProgress ? Color.orange.opacity(0.12) : Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(challenge.zoneUnlocked
                        ? Color.orange.opacity(0.15)
                        : Color.gray.opacity(0.08), lineWidth: 1)
        )
        .opacity(challenge.zoneUnlocked ? 1 : 0.55)
    }

    @ViewBuilder
    var statusPill: some View {
        if !challenge.zoneUnlocked {
            pill(text: "Bloqueado",   fg: .gray,   bg: Color.gray.opacity(0.1))
        } else if challenge.isCompleted {
            pill(text: "✓ Listo",     fg: .green,  bg: Color.green.opacity(0.1))
        } else if challenge.isInProgress {
            pill(text: "En progreso", fg: .orange, bg: Color.orange.opacity(0.1))
        } else {
            pill(text: "Nuevo",       fg: .blue,   bg: Color.blue.opacity(0.1))
        }
    }

    func pill(text: String, fg: Color, bg: Color) -> some View {
        Text(text)
            .font(.caption2).fontWeight(.semibold)
            .foregroundColor(fg)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(bg).clipShape(Capsule())
    }

    var difficultyTag: some View {
        Text(challenge.difficulty.rawValue)
            .font(.caption2).fontWeight(.semibold)
            .foregroundColor(difficultyColor)
            .padding(.horizontal, 7).padding(.vertical, 3)
            .background(difficultyColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    var xpTag: some View {
        Text("⚡ \(challenge.xpReward) xp")
            .font(.caption2).fontWeight(.semibold)
            .foregroundColor(.purple)
            .padding(.horizontal, 7).padding(.vertical, 3)
            .background(Color.purple.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct ChallengeStartedView: View {
    let challenge: Challenge
    @Environment(\.dismiss) var dismiss
    @State private var animateIn = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.08), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.12))
                        .frame(width: 110, height: 110)
                        .scaleEffect(animateIn ? 1 : 0.4)
                    Circle()
                        .stroke(Color.orange.opacity(0.25), lineWidth: 2)
                        .frame(width: 110, height: 110)
                        .scaleEffect(animateIn ? 1 : 0.4)
                    Image(systemName: challenge.icon)
                        .font(.system(size: 46))
                        .foregroundColor(.orange)
                        .scaleEffect(animateIn ? 1 : 0.3)
                        .rotationEffect(.degrees(animateIn ? 0 : -20))
                }
                .opacity(animateIn ? 1 : 0)

                VStack(spacing: 10) {
                    Text("¡Reto iniciado!")
                        .font(.title)
                        .fontWeight(.bold)
                        .opacity(animateIn ? 1 : 0)
                        .offset(y: animateIn ? 0 : 16)

                    Text(challenge.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .opacity(animateIn ? 1 : 0)
                        .offset(y: animateIn ? 0 : 16)

                    Text(challenge.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .opacity(animateIn ? 1 : 0)
                        .offset(y: animateIn ? 0 : 16)
                }

                VStack(spacing: 10) {
                    ForEach(challenge.tasks) { task in
                        HStack(spacing: 12) {
                            Circle()
                                .stroke(Color.orange.opacity(0.4), lineWidth: 1.5)
                                .frame(width: 22, height: 22)
                            Text(task.title)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.orange.opacity(0.15), lineWidth: 1))
                .padding(.horizontal)
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 20)

                Spacer()

                Button { dismiss() } label: {
                    Text("¡Vamos!")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 20)
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(28)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.1)) {
                animateIn = true
            }
        }
        .onDisappear { animateIn = false }
    }
}

#Preview {
    MissionView()
}
