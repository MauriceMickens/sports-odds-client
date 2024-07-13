//
//  PlayerConsistencyView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct PlayerConsistencyView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Player Consistency")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Points Consistency")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            BarChartSwiftUIView(data: viewModel.playerPerformances.map { $0.points })
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text("Consistency Score: 85%")
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}

struct GameByGameAnalysisView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Game-by-Game Analysis")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            ForEach(viewModel.playerPerformances) { performance in
                HStack {
                    Text(performance.game)
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(performance.points, specifier: "%.2f") Points")
                        .foregroundColor(.blue)
                    Text("\(performance.rebounds, specifier: "%.2f") Rebounds")
                        .foregroundColor(.green)
                    Text("\(performance.assists, specifier: "%.2f") Assists")
                        .foregroundColor(.orange)
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
