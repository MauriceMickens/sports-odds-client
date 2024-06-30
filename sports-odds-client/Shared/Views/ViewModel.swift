//
//  ViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/29/24.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype ObjectType
    associatedtype StateType
    
    @MainActor var loadingState: LoadingState<StateType> { get }
    @MainActor var hasMore: Bool { get }
    @MainActor var objects: [ObjectType] { get }
    
    func loadData() async throws
}
