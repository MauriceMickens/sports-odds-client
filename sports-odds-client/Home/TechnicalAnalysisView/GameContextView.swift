//
//  GameContextView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct GameContextView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Game Context")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            ForEach(viewModel.playerPerformances) { performance in
                VStack(alignment: .leading) {
                    Text(performance.game)
                        .font(.headline)
                    HStack {
                        Text("Opponent Defensive Rating:")
                            .fontWeight(.medium)
                        Text("\(performance.opponentDefensiveRating, specifier: "%.2f")")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Opponent Ranking:")
                            .fontWeight(.medium)
                        Text("#\(performance.opponentRanking)")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Opponent Win/Loss Record:")
                            .fontWeight(.medium)
                        Text(performance.opponentWinLossRecord)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}
