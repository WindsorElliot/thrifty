//
//  HomeSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import SwiftUI
import FirebaseAuth

struct HomeSwiftUIView: View {
    private let context: AppContext
    
    @State var message: String = ""
    @State var showError: Bool = false
    @State var showMenu: Bool = false
    
    init(context: AppContext = AppContext.shared) {
        self.context = context
    }
    
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
                    
                    ScrollView {
                        WalletsSwiftUIView(viewModel: WalletViewModel(context: self.context))
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
                    .foregroundColor(self.showMenu == false ? Color.black : Color.white)
            }, trailing: Button(action: {
                
            }) {
                Image.init(systemName: "plus")
                    .foregroundColor(.black)
            })
        }
        .foregroundColor(.white)
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView(context: AppContext(type: .preview))
            
    }
}
