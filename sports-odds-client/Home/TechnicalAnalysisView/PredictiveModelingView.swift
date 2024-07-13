//
//  PredictiveModelingView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct PredictiveModelingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Predictive Modeling")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Predicted Points")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            LineChartSwiftUIView(data: [15, 17, 16, 18, 19])
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text("Predicted Avg Points: 16.5")
                .font(.headline)
                .foregroundColor(.blue)
            Text("Prediction Accuracy: 78%")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}
