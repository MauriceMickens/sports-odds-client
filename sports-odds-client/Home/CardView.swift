//
//  CardView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/23/24.
//

import SwiftUI

struct CardView: View {
    var odds: Odds
    
    var body: some View {
        VStack {
            if let thumbnailURL = odds.playerImageUrls?.thumbnailURL {
                AsyncImage(url: thumbnailURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // Adjust size as needed
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50) // Adjust size as needed
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            Text(odds.player)
                .font(.title3)
            Text(odds.homeTeam)
                .font(.callout)
            Text(odds.gameDate)
            Spacer()
        }
        .padding(10.0)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    CardView(odds: Odds.random)
        .frame(width: 150, height: 220)
        .padding()
        .background(Color.black)
}
