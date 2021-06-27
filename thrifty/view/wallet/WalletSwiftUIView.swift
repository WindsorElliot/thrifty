//
//  WalletSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 27/06/2021.
//

import SwiftUI

struct WalletSwiftUIView: View {
    @State var wallet: Wallet
    
    private let itemWize = (UIScreen.main.bounds.size.width - 60)/2
    
    private var amountFormater: NumberFormatter {
        let f = NumberFormatter()
        f.decimalSeparator = ","
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        
        return f
    }
    
    
    var body: some View {
            VStack {
                HStack {
                    self.wallet.icon
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    Text(self.wallet.name)
                        .foregroundColor(.black)
                        .font(.title3)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
                
                HStack {
                    Image(systemName: "eurosign.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(self.amountFormater.string(from: self.wallet.solde as NSNumber) ?? "0.0") €")
                        .foregroundColor(.black)
                        .font(.title3)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            .background(Color.white)
            .frame(width: itemWize)
            .cornerRadius(10)
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
        }
}

struct WalletSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WalletSwiftUIView(wallet: Wallet(id: UUID().uuidString, name: "Amex", _createdDate: Date().timeIntervalSince1970, spents: nil, type: .week, amount: 50, iconName: nil))
    }
}
