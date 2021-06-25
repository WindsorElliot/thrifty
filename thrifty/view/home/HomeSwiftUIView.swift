//
//  HomeSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import SwiftUI
import FirebaseAuth

struct HomeSwiftUIView: View {
    @State var message: String = ""
    @State var showError: Bool = false
    
    var body: some View {
        ZStack {
            
            Spacer()
            Spacer()
            
            Button {
                do {
                    try Auth.auth().signOut()
                }
                catch {
                    self.message = error.localizedDescription
                    self.showError = true
                }
            } label: {
                Text("Déconnexion")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.red)
            .cornerRadius(15.0)
        }
        .alert(isPresented: self.$showError) {
            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .cancel())
        }
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}
