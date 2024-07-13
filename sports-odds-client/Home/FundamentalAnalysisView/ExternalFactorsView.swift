//
//  ExternalFactorsView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct ExternalFactorsView: View {
    @ObservedObject var viewModel: FundamentalAnalysisViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("External Factors")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            ForEach(viewModel.externalFactors) { factor in
                VStack(alignment: .leading, spacing: 5) {
                    Text(factor.title)
                        .font(.headline)
                    Text(factor.detail)
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

struct ExternalFactor: Identifiable {
    var id = UUID()
    var title: String
    var detail: String
}
