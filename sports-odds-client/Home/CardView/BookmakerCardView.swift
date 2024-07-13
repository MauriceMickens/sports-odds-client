//
//  ConsolidatedBookmakerCardView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/13/24.
//

import SwiftUI

struct BookmakerCardView: View {
    @State var viewModel: BookmakerCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                Text(viewModel.bookmakerGroup.bookmakerName)
                    .font(.headline)
                    .padding(5)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(5)
                
                Text("|")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text("\(viewModel.selectedMarket.description): \(viewModel.bookmakerGroup.bookmakers.first?.point ?? 0, specifier: "%.2f")")
                    .font(.subheadline)
                    .padding(5)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(5)
            }
            .padding(.bottom, 5)
            
            HStack(alignment: .top, spacing: 10) {
                ForEach(viewModel.bookmakerGroup.bookmakers) { bookmaker in
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(viewModel.betType(bookmaker))
                                .font(.subheadline)
                            Spacer()
                            viewModel.iconForExpectedValue(bookmaker.expectedValue)
                        }
                        Text(viewModel.odds(bookmaker))
                            .font(.subheadline)
                        Text(viewModel.probability(bookmaker))
                            .font(.subheadline)
                        Text(viewModel.profit(bookmaker))
                            .font(.subheadline)
                        Text(viewModel.expectedValue(bookmaker))
                            .font(.subheadline)
                            .foregroundColor(viewModel.colorForExpectedValue(bookmaker.expectedValue))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.colorForExpectedValue(bookmaker.expectedValue), lineWidth: 2)
                    )
                }
            }
            
            if let bookmaker = viewModel.bookmakerGroup.bookmakers.first {
                Text(viewModel.lastUpdated(bookmaker))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}
