//
//  CardDetailViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 7/4/24.
//

import Foundation

class CardDetailViewModel: ObservableObject {
    let odds: Odds
    
    init(odds: Odds) {
        self.odds = odds
    }
}
