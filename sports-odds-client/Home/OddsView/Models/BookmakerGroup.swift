//
//  BookmakerGroup.swift
//  sports-odds-client
//
//  Created by Mickens on 7/13/24.
//

import Foundation

struct BookmakerGroup: Identifiable {
    let id = UUID()
    let bookmakerName: String
    let bookmakers: [Bookmaker]
}

extension Sequence {
    func grouped<U: Hashable>(by key: (Element) -> U) -> [U: [Element]] {
        Dictionary(grouping: self, by: key)
    }

    func groupedBookmakerGroups(by key: (Element) -> String) -> [BookmakerGroup] where Element == Bookmaker {
        let grouped = self.grouped(by: key)
        return grouped.map { BookmakerGroup(bookmakerName: $0.key, bookmakers: $0.value) }
    }
}
