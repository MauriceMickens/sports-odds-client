//
//  LineChartSwiftUIView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import Charts
import SwiftUI

struct LineChartSwiftUIView: View {
    var data: [Double]
    
    var body: some View {
        Chart {
            ForEach(data.indices, id: \.self) { index in
                LineMark(
                    x: .value("Game", index),
                    y: .value("Points", data[index])
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(Color.blue.gradient)
            }
        }
        .frame(height: 200)
    }
}

struct BarChartSwiftUIView: View {
    var data: [Double]
    
    var body: some View {
        Chart {
            ForEach(data.indices, id: \.self) { index in
                BarMark(
                    x: .value("Game", index),
                    y: .value("Points", data[index])
                )
                .foregroundStyle(Color.blue.gradient)
            }
        }
        .frame(height: 200)
    }
}
