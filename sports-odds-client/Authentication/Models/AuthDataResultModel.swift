//
//  AuthDataResultModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import FirebaseAuth
import Foundation

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: UserInfo) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
    init(email: String = "", photoUrl: String? = nil) {
        self.uid = UUID().uuidString
        self.email = email
        self.photoUrl = photoUrl
    }
}
