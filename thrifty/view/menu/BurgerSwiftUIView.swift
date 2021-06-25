//
//  BurgerSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 25/06/2021.
//

import SwiftUI

struct BurgerSwiftUIView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
            Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
                
            }
            .padding([.top], 100)
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Message")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding([.top], 30)
            
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Réglage")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding([.top], 30)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
    }
}

struct BurgerSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerSwiftUIView()
    }
}
