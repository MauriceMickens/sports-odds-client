//
//  ComparativeAnalysisView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct ComparativeAnalysisView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Comparative Analysis")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            if let leagueAverages = viewModel.leagueAverages {
                VStack(alignment: .leading) {
                    Text("Compared to League Averages:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Points:")
                                .fontWeight(.medium)
                            Text("Player: \(viewModel.getRollingAverage(for: 5, type: .points), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text("League: \(leagueAverages.points, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Shooting %:")
                                .fontWeight(.medium)
                            Text("Player: \(viewModel.getRollingAverage(for: 5, type: .shootingPercentage), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.green)
                            Text("League: \(leagueAverages.shootingPercentage, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Minutes:")
                                .fontWeight(.medium)
                            Text("Player: \(viewModel.getRollingAverage(for: 5, type: .minutes), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.orange)
                            Text("League: \(leagueAverages.minutes, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            if !viewModel.similarPlayers.isEmpty {
                VStack(alignment: .leading) {
                    Text("Compared to Similar Players:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ForEach(viewModel.similarPlayers) { player in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(player.game)
                                    .fontWeight(.medium)
                                Text("Points: \(player.points, specifier: "%.2f")")
                                    .foregroundColor(.blue)
                                Text("Shooting %: \(player.shootingPercentage, specifier: "%.2f")")
                                    .foregroundColor(.green)
                                Text("Minutes: \(player.minutes, specifier: "%.2f")")
                                    .foregroundColor(.orange)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}
