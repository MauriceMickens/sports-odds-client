//
//  FundamentalAnalysisView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct FundamentalAnalysisView: View {
    @ObservedObject var viewModel = FundamentalAnalysisViewModel()
    @State private var selectedSegment = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FundamentalHeaderView()
            
            FundamentalSegmentedControlView(selectedSegment: $selectedSegment)
            
            if selectedSegment == 0 {
                PlayerSpecificFactorsView(viewModel: viewModel)
            } else if selectedSegment == 1 {
                TeamSpecificFactorsView(viewModel: viewModel)
            } else if selectedSegment == 2 {
                MatchupSpecificFactorsView(viewModel: viewModel)
            } else if selectedSegment == 3 {
                ScenarioContextualFactorsView(viewModel: viewModel)
            } else if selectedSegment == 4 {
                ExternalFactorsView(viewModel: viewModel)
            } else if selectedSegment == 5 {
                PerformanceVarianceView(viewModel: viewModel)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct FundamentalHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fundamental Analysis")
                .font(.largeTitle)
                .bold()
            Text("Perform detailed analysis to make informed betting decisions.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct FundamentalSegmentedControlView: View {
    @Binding var selectedSegment: Int
    
    var body: some View {
        Picker("", selection: $selectedSegment) {
            Text("Player Factors").tag(0)
            Text("Team Factors").tag(1)
            Text("Matchup Factors").tag(2)
            Text("Scenario Context").tag(3)
            Text("External Factors").tag(4)
            Text("Performance Variance").tag(5)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

