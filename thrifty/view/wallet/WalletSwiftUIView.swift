//
//  WalletSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 25/06/2021.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct WalletSwiftUIView: View {
    @ObservedObject var walletViewModel: WalletViewModel = WalletViewModel()
    let handleTapShowMenuButton: () -> Void
    
    var body: some View {
        VStack {
            Button {
                self.handleTapShowMenuButton()
            } label: {
                Text("show Menu")
                    .foregroundColor(Color.white)
            }
            
//            List(self.walletViewModel.wallets, id: \.id) {
//                Text($0.name)
//            }
        }
    }
}

//struct WalletSwiftUIView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        WalletSwiftUIView {
//            print("tap tap")
//        }
//    }
//}
