//
//  TechnicalAnalysisView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct TechnicalAnalysisView: View {
    @ObservedObject var viewModel = TechnicalAnalysisViewModel()
    @State private var selectedSegment = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TechnicalHeaderView()
            
            SegmentedControlView(selectedSegment: $selectedSegment)
            
            if selectedSegment == 0 {
                RollingAveragesView(viewModel: viewModel)
            } else if selectedSegment == 1 {
                PredictiveModelingView()
            } else if selectedSegment == 2 {
                PlayerConsistencyView(viewModel: viewModel)
            } else if selectedSegment == 3 {
                GameByGameAnalysisView(viewModel: viewModel)
            } else if selectedSegment == 4 {
                MarketDataView(viewModel: viewModel)
            } else if selectedSegment == 5 {
                ComparativeAnalysisView(viewModel: viewModel)
            } else if selectedSegment == 6 {
                GameContextView(viewModel: viewModel)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct TechnicalHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Alyssa Thomas")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text("Connecticut Sun vs New York Liberty")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Jul 10, 2024 at 11:00 AM")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.bottom, 10)
    }
}

struct SegmentedControlView: View {
    @Binding var selectedSegment: Int
    
    var body: some View {
        Picker("", selection: $selectedSegment) {
            Text("Rolling Avg").tag(0)
            Text("Predictive Modeling").tag(1)
            Text("Consistency").tag(2)
            Text("Game-by-Game").tag(3)
            Text("Market Data").tag(4)
            Text("Comparison").tag(5)
            Text("Context").tag(6)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct TechnicalAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        TechnicalAnalysisView()
    }
}
