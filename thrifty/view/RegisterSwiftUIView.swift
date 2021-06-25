//
//  RegisterSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import SwiftUI

struct RegisterSwiftUIView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    private let verticalPaddingForForm = 40.0
    
    let handleTapCreateAccountButton: (_ email: String, _ password: String) -> Void
    let handleTapBackButton: () -> Void
    
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Création de compte")
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
                        self.handleTapCreateAccountButton(email, password)
                    } label: {
                        Text("Créer mon compte")
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
            .navigationBarItems(leading: Button(action: {
                self.handleTapBackButton()
            }, label: {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .foregroundColor(.white)
            }))
        }
    }
}

struct RegisterSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSwiftUIView { email, password in
            print("tap tap")
        } handleTapBackButton: {
            print("tap tap")
        }

    }
}
