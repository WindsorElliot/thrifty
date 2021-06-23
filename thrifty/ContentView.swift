//
//  ContentView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
