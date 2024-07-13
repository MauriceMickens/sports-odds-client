//
//  RollingAveragesView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

struct RollingAveragesView: View {
    @ObservedObject var viewModel: TechnicalAnalysisViewModel
    @State private var selectedTimeFrame = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Rolling Averages")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Picker("Time Frame", selection: $selectedTimeFrame) {
                Text("Last 5 Games").tag(5)
                Text("Last 10 Games").tag(10)
                Text("Last 20 Games").tag(20)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            
            Text("Last \(selectedTimeFrame) Games")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            LineChartSwiftUIView(data: viewModel.getRollingAverageData(for: selectedTimeFrame))
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Average Points:")
                        .fontWeight(.medium)
                    Text("\(viewModel.getRollingAverage(for: selectedTimeFrame, type: .points), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Shooting %:")
                        .fontWeight(.medium)
                    Text("\(viewModel.getRollingAverage(for: selectedTimeFrame, type: .shootingPercentage), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Minutes Played:")
                        .fontWeight(.medium)
                    Text("\(viewModel.getRollingAverage(for: selectedTimeFrame, type: .minutes), specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}
