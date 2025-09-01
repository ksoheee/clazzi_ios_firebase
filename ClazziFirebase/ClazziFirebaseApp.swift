//
//  ClazziFirebaseApp.swift
//  ClazziFirebase
//
//  Created by Admin on 9/1/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

@main
struct ClazziFirebaseApp: App {
    @StateObject var session = UserSession()
    
    //인트로 화면 상태
    @State private var isLoading = true

    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Group{
                if isLoading{
                    //ProgressView("인트로 화면...") swift가 기본 제공
                    IntroView()
                } else if session.user == nil {
                    AuthView()
                } else{
                    VoteListView()
                }
            }
            .onAppear{
                Task{
                    try await Task.sleep(seconds: 2) //2초
                    isLoading = false
                }
            }
            .environmentObject(session)
        }
    }
}


