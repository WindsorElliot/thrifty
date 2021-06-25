//
//  LoginSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import SwiftUI

struct LoginSwiftUIView: View {
    let handleTapConnectButton: (_ email: String, _ password: String) -> Void
    let handleTapRegisterButton: () -> Void
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Welcome to Thrifty")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding([.bottom], 40)
                    .padding([.top], 10)
                
                Spacer()
                
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    TextField("e-mail", text: self.$email)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    TextField("mot de passe", text: self.$password)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                Spacer()
                
                
                Button {
                    self.handleTapConnectButton(self.email, self.password)
                } label: {
                    Text("Connexion")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(15.0)
                
                Button {
                    self.handleTapRegisterButton()
                } label: {
                    Text("Créer un compte")
                        .padding([.horizontal], 58)
                        .padding([.vertical], 20)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(15.0)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, CGFloat(verticalPaddingForForm))
        }
    }
}

struct LoginSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSwiftUIView { email, password in
            print("tap tap")
        } handleTapRegisterButton: {
            print("tap tap")
        }
        
    }
}
