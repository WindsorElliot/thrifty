//
//  WalletSheetViewSwiftUIView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 25/06/2021.
//

import SwiftUI

struct WalletSheetViewSwiftUIView: View {
    let handleTapCreateButton: (_ name: String, _ amount: String, _ type: Int) -> Void
    
    @State var name: String = ""
    @State var amount: String = ""
    @State var type: Int = WalletCountType.week.rawValue
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Nom du portefeuille") {
                        TextField("Nom", text: self.$name)
                    }
                    Section("Budget du porteufeille") {
                        TextField("budget", text: self.$amount)
                    }
                    Section("Type de porteufeuille") {
                        Picker(selection: self.$type, label: Text("type")) {
                            ForEach(WalletCountType.allCases, id: \.rawValue) {
                                Text($0.descriptionName)
                            }
                        }
                    }
                }
                Button {
                    
                } label: {
                    Text("Enregister")
                }
            }
            .navigationTitle("Nouveau Portefeuille")
        }
    }
}

struct WalletSheetViewSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WalletSheetViewSwiftUIView { (name, amount, type) in
            print("tap tap")
        }
    }
}
