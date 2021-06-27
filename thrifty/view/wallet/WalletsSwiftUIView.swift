//
//  WalletSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 25/06/2021.
//

import SwiftUI
import UIKit

struct WalletsSwiftUIView: View {
    @ObservedObject var walletViewModel: WalletViewModel
    
    init(viewModel: WalletViewModel = WalletViewModel()) {
        self.walletViewModel = viewModel
    }
    
    private let itemWize = (UIScreen.main.bounds.size.width - 60)/2
    
    private var columns: [GridItem] {
        return [
            GridItem(.fixed(itemWize), spacing: 20, alignment: .center),
            GridItem(.fixed(itemWize), spacing: 20, alignment: .center)
        ]
    }
    
    private var colors: [Color] = [.yellow, .purple, .green]
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(self.walletViewModel.wallets, id: \.id) { aWallet in
                WalletSwiftUIView(wallet: aWallet)
            }
        }
    }
}

struct WalletsSwiftUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        WalletsSwiftUIView(viewModel: WalletViewModel(context: AppContext(type: .preview)))
    }
}
