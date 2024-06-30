//
//  DataLoader.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation
import UIKit

protocol DataLoader {
    associatedtype FailureModel: Error
    
    func load<Model: Decodable>(url: URL) async throws -> Model
    func load(url: URL) async throws -> UIImage
}
