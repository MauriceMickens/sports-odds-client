//
//  ImageLoader.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation
import UIKit

protocol ImageLoader {
    func load(url: URL) async throws -> UIImage
}
