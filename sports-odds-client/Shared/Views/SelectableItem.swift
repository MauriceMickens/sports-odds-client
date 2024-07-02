//
//  SelectableItem.swift
//  sports-odds-client
//
//  Created by Mickens on 7/1/24.
//

import Foundation

protocol SelectableItem: Identifiable, Hashable {
    var key: String { get }
    var description: String { get }
}
