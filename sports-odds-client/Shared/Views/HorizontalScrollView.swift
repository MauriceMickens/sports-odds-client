//
//  HorizontalScrollView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/1/24.
//

import Foundation
import SwiftUI

struct HorizontalScrollRow<Item: SelectableItem>: View {
    @Binding var selectedItem: Item
    let items: [Item]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(items) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        Text(item.description)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedItem.key == item.key ? Color.green : Color.blue)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedItem.key == item.key ? Color.green : Color.clear, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
