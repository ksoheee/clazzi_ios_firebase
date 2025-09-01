//
//  UserSession.swift
//  ClazziFirebase
//
//  Created by Admin on 9/1/25.
//

import Foundation
import FirebaseAuth

//뷰모델
class UserSession: ObservableObject {
    @Published var user: User?  //파이어베이스에 있는 User Model
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.user = Auth.auth().currentUser  //currentUser가 없다면 handel이 nil
        handle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }
}

