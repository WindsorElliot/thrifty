//
//  WalletSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 25/06/2021.
//

import SwiftUI

struct WalletSwiftUIView: View {
    let handleTapShowMenuButton: () -> Void
    
    var body: some View {
        Button {
            self.handleTapShowMenuButton()
        } label: {
            Text("show Menu")
                .foregroundColor(Color.white)
        }

    }
}

struct WalletSwiftUIView_Previews: PreviewProvider {
    @State var showMenu: Bool = false
    
    static var previews: some View {
        
        WalletSwiftUIView {
            print("tap tap")
        }
    }
}
