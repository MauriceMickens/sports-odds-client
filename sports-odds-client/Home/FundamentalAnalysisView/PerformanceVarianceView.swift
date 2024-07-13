//
//  PerformanceVarianceView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct PerformanceVarianceView: View {
    @ObservedObject var viewModel: FundamentalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Performance Variance")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            ForEach(viewModel.performanceVariance) { variance in
                VStack(alignment: .leading, spacing: 5) {
                    Text(variance.title)
                        .font(.headline)
                    Text(variance.detail)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.vertical, 5)
            }
        }
        .padding()
    }
}

struct PerformanceVariance: Identifiable {
    var id = UUID()
    var title: String
    var detail: String
}
