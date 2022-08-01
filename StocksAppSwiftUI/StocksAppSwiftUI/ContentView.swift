//
//  ContentView.swift
//  StocksAppSwiftUI
//
//  Created by gaeng on 2022/08/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                Text("Aug 1 2022")
                    .font(.custom("Arial", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                .padding(EdgeInsets(top: 0, leading: -120, bottom: 0, trailing: 0))
                    .offset(y: -210)
            }
            .navigationTitle("Stocks")
        }.edgesIgnoringSafeArea(Edge.Set(.bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
