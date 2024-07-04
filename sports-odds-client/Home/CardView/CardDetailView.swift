//
//  CardDetailView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/3/24.
//

import Combine
import SwiftUI

struct CardDetailView: View {
    @StateObject var viewModel: CardDetailViewModel
    
    init(odds: Odds) {
        _viewModel = StateObject(wrappedValue: .init(odds: odds))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CardDetailView(odds: Odds.random)
}

