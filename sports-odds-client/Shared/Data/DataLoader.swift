//
//  DataLoader.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

protocol DataLoader {
    associatedtype SuccessModel
    associatedtype FailureModel: Error
    
    func load(url: URL) async throws -> SuccessModel
}

protocol FeedLoader: DataLoader {}
