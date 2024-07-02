//
//  Market.swift
//  sports-odds-client
//
//  Created by Mickens on 7/1/24.
//

import Foundation

struct Market: Identifiable, Decodable, Hashable {
    let id = UUID()
    let key: String
    let description: String
}

extension Market: SelectableItem {}
