//
//  LoadingState.swift
//  sports-odds-client
//
//  Created by Mickens on 6/29/24.
//

import Foundation

enum LoadingState<T, E> {
    case idle
    case loading
    case loaded(objects: T)
    case error(error: E)
}
