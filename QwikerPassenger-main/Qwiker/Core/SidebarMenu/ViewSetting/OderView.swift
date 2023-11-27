//
//  OderView.swift
//  Qwiker
//
//  Created by Lê Phước on 18/09/2023.
//

import SwiftUI

struct OrderHistoryView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(0..<4, id: \.self) { index in
                        Image("image\(index + 1)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 200)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
            }
            .navigationBarTitle("Lịch sử đơn hàng", displayMode: .inline)
        }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
