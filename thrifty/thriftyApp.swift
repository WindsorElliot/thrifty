//
//  thriftyApp.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import SwiftUI
import Firebase

@main
struct thriftyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
