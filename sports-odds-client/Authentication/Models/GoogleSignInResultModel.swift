//
//  GoogleSignInResultModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}
