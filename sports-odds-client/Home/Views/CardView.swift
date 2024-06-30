//
//  CardView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/23/24.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel: CardViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                viewModel.playerImage?
                    .resizable()
                    .scaledToFit()
            }
            
            Text(viewModel.playerName)
                .font(.headline)
            Text(viewModel.homeTeam)
                .font(.subheadline)
            Text(viewModel.gameDate)
                .font(.caption)
            Spacer()
        }
        .padding(10.0)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    CardView(viewModel: CardViewModel(odds: Odds.random))
        .padding()
        .background(Color.black)
}

