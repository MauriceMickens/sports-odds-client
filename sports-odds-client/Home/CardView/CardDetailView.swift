//
//  CardDetailView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/3/24.
//

import Charts
import Combine
import SwiftUI

struct CardDetailView: View {
    @State private var selectedSegment = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedSegment) {
                Text("Fundamental Analysis").tag(0)
                Text("Technical Analysis").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            if selectedSegment == 0 {
                FundamentalAnalysisView()
            } else if selectedSegment == 1 {
                TechnicalAnalysisView()
            }
        }
    }
}
