//
//  HTTPClient.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

public typealias HTTPClientResponse = (data: Data, response: URLResponse)

public protocol HTTPClient {
    func get(from url: URL) async throws -> HTTPClientResponse
    func post(request: URLRequest) async throws -> HTTPClientResponse
}
