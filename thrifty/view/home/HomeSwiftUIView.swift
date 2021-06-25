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
    @State var showMenu: Bool = false
    
    var body: some View {
        let dragGestuire = DragGesture()
            .onEnded { value in
                if value.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                    WalletSwiftUIView {
                        withAnimation {
                            self.showMenu = true
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu)
                    
                    if self.showMenu {
                        BurgerSwiftUIView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(dragGestuire)
            }
            .alert(isPresented: self.$showError) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .cancel())
            }
            .navigationBarTitle(self.showMenu == false ? "Your Wallets" : "")
            .navigationBarItems(leading: Button(action: {
                withAnimation {
                    self.showMenu = !self.showMenu
                }
            }) {
                Image(systemName: self.showMenu == false ? "line.horizontal.3" : "xmark")
                    .imageScale(.large)
            }, trailing: Button(action: {
                
            }) {
                
            })
        }
        .foregroundColor(.white)
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}
