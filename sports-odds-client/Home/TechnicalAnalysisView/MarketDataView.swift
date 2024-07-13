//
//  MarketDataView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct MarketDataView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Market Data")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Odds Movement")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            LineChartSwiftUIView(data: viewModel.playerPerformances.map { $0.oddsClosing })
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Opening Odds:")
                        .fontWeight(.medium)
                    Text("\(viewModel.playerPerformances.first?.oddsOpening ?? 0, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Closing Odds:")
                        .fontWeight(.medium)
                    Text("\(viewModel.playerPerformances.last?.oddsClosing ?? 0, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Odds Change:")
                        .fontWeight(.medium)
                    Text("\((viewModel.playerPerformances.last?.oddsClosing ?? 0) - (viewModel.playerPerformances.first?.oddsOpening ?? 0), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.red)
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
